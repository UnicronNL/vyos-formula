{%- if salt['pillar.get']('vyos_config:config.boot') %}
  {% set vyosconfig = salt['pillar.get']('vyos_config:config.boot') %}
  vyos_config.boot:
    file.managed:
      - name: /config/config.boot
      - user: root
      - group: vyattacfg
      - mode: 644
      - source: {{ vyosconfig }}

  cmd_config.boot:
    cmd.script:
      - source: salt://vyos/files/loadconf.sh
      - user: vyos
      - onchanges:
        - file: vyos_config.boot
{%- endif %}

