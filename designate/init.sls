{%- if pillar.designate is defined %}
include:
{%- if pillar.designate.server is defined %}
- designate.server
{%- endif %}
{%- endif %}
