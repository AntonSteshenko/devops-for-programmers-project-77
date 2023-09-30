terraform {
  required_version = ">=1.0.0"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
    # zabbix = {
    #   source = "claranet/zabbix"
    #   version = "0.4.0"
    # } 
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}

# provider "zabbix" {
#   user       = var.zabbix_user
#   password   = var.zabbix_password
#   server_url = var.zabbix_server_url
# }