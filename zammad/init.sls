{%- from "zammad/map.jinja" import config with context %}
python-pip:
  pkg.installed

install_compose:
  pip.installed:
  - name: docker-compose
  - require:
    - pkg: python-pip

{{ config.location }}:
  file.directory:
    - mode: 755
    - makedirs: True

zammad_env_file:
  file.serialize:
  - name: {{ config.location }}/.env
  - formatter: configparser
  - dataset: {{ config.env }}
#  - source: salt://zammad/files/.env.jinja2
#  - template: jinja

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
