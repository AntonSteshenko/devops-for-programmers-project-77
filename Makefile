change-secrets:
	ansible-vault edit ansible/group_vars/all/vault.yml --vault-password-file tmp/ansible-vault-password

install-ansible-deps:
	ansible-galaxy install -r ansible/requirements.yml

terraform-secrets:
	ansible-playbook ansible/playbooks/terraform.yml --vault-password-file tmp/ansible-vault-password

envfile:
	ansible-playbook ansible/playbooks/envfile.yml --vault-password-file tmp/ansible-vault-password

infrastructure-init:
	terraform -chdir=terraform/ init 

infrastructure-plan:
	terraform -chdir=terraform/ plan

infrastructure-apply:
	terraform -chdir=terraform/ apply

infrastructure-destroy:
	terraform -chdir=terraform/ destroy

setup-servers:
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini --vault-password-file tmp/ansible-vault-password

clean-ssh:
	ssh-keygen -f "/home/anton/.ssh/known_hosts" -R "camion-demo-1.rdas.site" 
	ssh-keygen -f "/home/anton/.ssh/known_hosts" -R "camion-demo-2.rdas.site"

deploy:
	ansible-playbook ansible/playbooks/deploy.yml -i ansible/inventory.ini --vault-password-file tmp/ansible-vault-password

load-init-data:
	ansible-playbook ansible/playbooks/initdata.yml -i ansible/inventory.ini --vault-password-file tmp/ansible-vault-password

