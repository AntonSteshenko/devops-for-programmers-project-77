Camion APP demo site

Requirements:

- ansible
- terraform
- ansible vault password

Install ansible dependencies:
`$ make install-ansible-deps`

Put ansible vault password to tmp/ansible-vault-password

If you want to change default setting (database ecc):
`$ make change-secrets`

`$ make terraform-secrets`

`$ make envfile`

`$ make infrastructure-init`

`$ make infrastructure-plan`

`$ make infrastructure-apply`

`$ export ANSIBLE_HOST_KEY_CHECKING=false`

`$ make setup-servers`

if you have ssh error `$ make clean-ssh` and run previous step

After successful setup check https://camion-demo.rdas.site/

To deploy or restart
`$ make deploy`

Create init data
`$ make load-init-data`

Monitoring

To install datadog agent:
put api-key in vault secrets, then:
`make install-datdog-agent`

### Hexlet tests and linter status:

[![Actions Status](https://github.com/AntonSteshenko/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/AntonSteshenko/devops-for-programmers-project-77/actions)
