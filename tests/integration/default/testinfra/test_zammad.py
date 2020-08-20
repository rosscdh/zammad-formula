def test_file_exists(host):
    zammad = host.file('/zammad.yml')
    assert zammad.exists
    assert zammad.contains('your')

# def test_zammad_is_installed(host):
#     zammad = host.package('zammad')
#     assert zammad.is_installed
#
#
# def test_user_and_group_exist(host):
#     user = host.user('zammad')
#     assert user.group == 'zammad'
#     assert user.home == '/var/lib/zammad'
#
#
# def test_service_is_running_and_enabled(host):
#     zammad = host.service('zammad')
#     assert zammad.is_enabled
#     assert zammad.is_running
