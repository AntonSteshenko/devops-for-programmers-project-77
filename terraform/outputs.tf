output "lb_output" {
  value = digitalocean_loadbalancer.public
}

# output "version" {
#   value = data.zabbix_server.main.server_version
# }