{%- from "designate/map.jinja" import server with context %}
{%- if server.enabled %}

{%- if server.backend is defined %}

{%- if server.backend.bind9 is defined %}

include:
- bind

{%- if server.backend.bind9.rndc_key is defined %}

/etc/designate/rndc.key:
  file.managed:
    - source: salt://designate/files/rndc.key
    - template: jinja
    - require:
      - pkg: bind9utils
      - pkg: designate_server_packages

{%- endif %}

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

designate_pool_sync:
  cmd.run:
    - name: designate-manage pool-manager-cache sync
    - require:
      - file: /etc/designate/designate.conf

designate_server_services:
  service.running:
    - enable: true
    - names: {{ server.services }}
    - require:
      - cmd: designate_syncdb
      - cmd: designate_pool_sync
    - watch:
      - file: /etc/designate/designate.conf

{%- if server.version not in ['liberty', 'juno', 'kilo'] and server.pools is defined %}
# Since Mitaka it is recommended to use pools.yaml for pools configuration
/etc/designate/pools.yaml:
  file.managed:
  - source: salt://designate/files/{{ server.version }}/pools.yaml
  - template: jinja
  - require:
    - pkg: designate_server_packages

designate_pool_update:
  cmd.run:
    - name: designate-manage pool update
    - require:
      - file: /etc/designate/pools.yaml
      - service: designate_server_services
{%- endif %}
{%- endif %}
