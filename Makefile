ansible-terraform-vars-generate:
	docker run --rm -e RUNNER_PLAYBOOK=ansible/terraform.yml \
		-v $(CURDIR):/runner/project \
		-e ANSIBLE_VAULT_PASSWORD_FILE=tmp/ansible-vault-password \
		quay.io/ansible/ansible-runner

ansible-vaults-edit:
	docker run -it --rm \
		-v $(CURDIR):/runner/project \
		quay.io/ansible/ansible-runner  ansible-vault edit --vault-password-file project/tmp/ansible-vault-password project/ansible/group_vars/all/vault.yml 
		