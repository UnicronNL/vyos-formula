{%- if salt['pillar.get']('vyos_config:config.boot') %}
  {% set vyosconfig = salt['pillar.get']('vyos_config:config.boot') %}
  vyos_chown_user:
    cmd.run:
      - name: sudo chown {{ salt['grains.get']('username') }}:vyattacfg /config/config.boot
      - prereq: 
        - file: vyos_config.boot

  vyos_config.boot:
    file.managed:
      - name: /config/config.boot
      - mode: 644
      - source: {{ vyosconfig }}

  vyos_chown_root:
    cmd.run:
      - name: sudo chown root:vyattacfg /config/config.boot
      - onchanges:
        - file: vyos_config.boot

  cmd_config.boot:
    cmd.script:
      - source: salt://vyos/files/loadconf.sh
      - user: {{ salt['grains.get']('username') }}
      - onchanges:
        - file: vyos_config.boot
{%- endif %}
