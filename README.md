# Goal

The objective here is to build something I can use.
I took some inspirations from [jgcasd/aws-netbox-deployment](https://github.com/jgcasd/aws-netbox-deployment).

## How to run

Ansible: `cd ansible && ansible-playbook -i inventory.ini playbooks/main.yml`

Terraform: `cd terraform && terraform apply --var-file="prod.tfvars"`
