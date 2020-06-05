#
# Basic Freifunk related information
#


/etc/freifunk:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True


# Generate /etc/freifunk/roles file with all roles configured on the node,
# one on each line.
/etc/freifunk/roles:
  file.managed:
    - source: salt://ffinfo/list.tmpl
    - template: jinja
      list: {{ salt['pillar.get']('nodes:' ~ grains['id'] ~ ':roles', []) }}


# Generate /etc/freifunk/sites file with all sites configured on the node,
# one on each line. Empty if no sites configured.
/etc/freifunk/sites:
  file.managed:
    - source: salt://ffinfo/list.tmpl
    - template: jinja
      list: {{ salt['pillar.get']('nodes:' ~ grains['id'] ~ ':sites', []) }}


# Generate /etc/freifunk/status file with the status of this node
{% set status = salt['pillar.get']('nodes:' ~ grains['id'] ~ ':status', 'active') %}
/etc/freifunk/status:
  file.managed:
    - contents: {{ status }}
