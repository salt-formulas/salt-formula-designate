{%- from "designate/map.jinja" import server with context %}
{%- if server.enabled %}

{%- if server.backend.bind9 is defined %}

designate_bind_packages:
  pkg.installed:
    - names:
      - bind9utils

{%- if server.backend.bind9.rndc_key is defined %}

/etc/designate/rndc.key:
  file.managed:
    - source: salt://designate/files/rndc.key
    - template: jinja
    - require:
      - pkg: bind9utils

{%- endif %}

{%- endif %}

designate_server_packages:
  pkg.installed:
    - names: {{ server.pkgs }}

/etc/designate/designate.conf:
  file.managed:
  - source: salt://designate/files/{{ server.version }}/designate.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - pkg: designate_server_packages

/etc/designate/api-paste.ini:
  file.managed:
  - source: salt://designate/files/{{ server.version }}/api-paste.ini
  - template: jinja
  - require:
    - pkg: designate_server_packages

designate_syncdb:
  cmd.run:
    - name: designate-manage database sync
    - require:
      - file: /etc/designate/designate.conf
      - pkg: designate_server_packages

designate_pool_sync:
  cmd.run:
    - name: designate-manage pool-manager-cache sync
    - require:
      - file: /etc/designate/designate.conf
      - pkg: designate_server_packages

designate_server_services:
  service.running:
    - enable: true
    - names: {{ server.services }}
    - require:
      - cmd: designate_syncdb
      - cmd: designate_pool_sync
    - watch:
      - file: /etc/designate/designate.conf

{%- endif %}
