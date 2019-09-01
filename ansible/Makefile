.PHONY: ansible netbox

ansible: pipenv install

netbox: ansible-playbook playbooks/netbox.yml -i inventory.ini
