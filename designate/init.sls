{%- if pillar.designate is defined %}
include:
{%- if pillar.designate.server is defined %}
- designate.server
{%- endif %}
{%- if pillar.designate.client is defined %}
- designate.client
{%- endif %}
{%- endif %}
