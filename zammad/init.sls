{%- from "zammad/map.jinja" import config with context %}
python-pip:
  pkg.installed

zammad_install_compose:
  pip.installed:
  - name: docker-compose
  - require:
    - pkg: python-pip

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


zammad-compose-down:
  cmd.run:
    - cwd: {{ config.location }}
    - name: docker-compose stop
    - watch:
      - file: {{ config.location }}/docker-compose.yml
      - file: {{ config.location }}/.env
      
zammad-compose-up:
  cmd.run:
    - cwd: {{ config.location }}
    - name: docker-compose up -d
    - watch:
      - file: {{ config.location }}/docker-compose.yml
      - file: {{ config.location }}/.env
