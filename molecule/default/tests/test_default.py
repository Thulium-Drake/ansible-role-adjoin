import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_ad_user(host):
    usergroup = 'domain users'
    users = [{'name': 'dom1usr', 'uid': 1277201126},
             {'name': 'dom2usr', 'uid': 1647801103}]
    for user in users:
        testuser = host.user(user['name'])
        assert testuser.name == user['name']
        assert testuser.group == usergroup
        assert testuser.uid == user['uid']
