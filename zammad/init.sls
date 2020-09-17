{%- from "zammad/map.jinja" import config with context %}

{{ config.location }}:
  file.directory:
    - mode: 755
    - makedirs: True

zammad_env_file:
  file.managed:
  - name: {{ config.location }}/.env
  - source: salt://zammad/files/.env.jinja2
  - template: jinja

zammad_compose_file:
  file.managed:
  - name: {{ config.location }}/docker-compose.yml
  - source: salt://zammad/files/docker-compose.yml.jinja2
  - template: jinja


{{ config.location }}/docker-compose.yml:
  dockercompose.restart:
    - enable: True
    - reload: True
    - watch:
      - zammad_compose_file
      - file: {{ config.location }}/.env
