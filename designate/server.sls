{%- from "designate/map.jinja" import server with context %}
{%- if server.enabled %}

{%- if server.local_bind %}
bind9:
  pkg.installed

/etc/bind/named.conf.options:
  file.managed:
    - source: salt://designate/files/named.conf.options
    - template: jinja
    - require:
      - pkg: bind9

bind9_service:
  service.running:
    - enable: true
    - name: bind9
    - watch:
      - file: /etc/bind/named.conf.options
{%- endif %}

designate_packages:
  pkg.installed:
    - names: {{ server.pkgs }}

/etc/designate/designate.conf:
  ini.options_present:
    - sections: {{ server.designate_config }}
    - require:
        - pkg: designate_packages

designate_db_sync:
  cmd.run:
    - name: designate-manage database sync
    - require:
      - ini: /etc/designate/designate.conf

designate_pool_sync:
  cmd.run:
    - name: designate-manage pool-manager-cache sync
    - require:
      - ini: /etc/designate/designate.conf

designate_server_services:
  service.running:
    - enable: true
    - names: {{ server.services }}
    - require:
      - cmd: designate_db_sync
      - cmd: designate_pool_sync
    - watch:
      - ini: /etc/designate/designate.conf

{%- endif %}
