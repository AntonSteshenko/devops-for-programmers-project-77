# Description: This file contains the main configuration for Terraform

# Terraform cloud 
terraform {
  cloud {
    organization = "risorsedaffari"

    workspaces {
      name = "project"
    }
  }
}

# Create droplets

resource "digitalocean_droplet" "camion-demo-1-droplet" {
  image  = "docker-20-04"
  name   = "camion-demo-1"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys   = [data.digitalocean_ssh_key.my_ssh_key.id]
}

resource "digitalocean_droplet" "camion-demo-2-droplet" {
  image  = "docker-20-04"
  name   = "camion-demo-2"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys   = [data.digitalocean_ssh_key.my_ssh_key.id]
}

# Create a DNS record for each droplet

resource "digitalocean_record" "camion-demo-1-dns" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "camion-demo-1"
  value  = digitalocean_droplet.camion-demo-1-droplet.ipv4_address
}

resource "digitalocean_record" "camion-demo-2-dns" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "camion-demo-2"
  value  = digitalocean_droplet.camion-demo-2-droplet.ipv4_address
}

# Create a load balancer

resource "digitalocean_loadbalancer" "public" {
  name   = "camion-demo-balancer-1"
  region = "fra1"

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = data.digitalocean_certificate.test.name
  }

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"

  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
  
  redirect_http_to_https = true
  droplet_ids = [digitalocean_droplet.camion-demo-1-droplet.id, digitalocean_droplet.camion-demo-2-droplet.id]
}

# Create a DNS record for the load balancer
resource "digitalocean_record" "camion-demo-dns" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "camion-demo"
  value  = digitalocean_loadbalancer.public.ip
}

# working database
resource "digitalocean_database_db" "camion-demo" {
  cluster_id = data.digitalocean_database_cluster.main.id
  name       = "camion-demo"
}

resource "digitalocean_database_firewall" "allow-droplets" {
  cluster_id = data.digitalocean_database_cluster.main.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.camion-demo-1-droplet.id
  }

  rule {
    type  = "droplet"
    value = digitalocean_droplet.camion-demo-2-droplet.id
  }
}

resource "datadog_monitor" "cpumonitor" {
  name = "cpu monitor"
  type = "metric alert"
  message = "CPU usage alert"
  query = "avg(last_1m):avg:system.cpu.system{*} by {host} > 60"
}

#resource "datadog_monitor" "http" {
#  name               = "Check http"
#  type               = "service check"
#  message            = "Monitor triggered."
#  escalation_message = "Escalation message"

  #query = "avg(last_1h):avg:aws.ec2.cpu{environment:foo,host:foo} by {host} > 4"
 # query = "http.over(*).last(3).by(host).count_by_status()"
#  monitor_thresholds {
 #   warning  = 2
 #   critical = 4
#  }
#}