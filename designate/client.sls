{%- from "designate/map.jinja" import client with context %}
{%- if client.enabled %}

designate_client_packages:
  pkg.installed:
  - names: {{ client.pkgs }}

{%- endif %}
