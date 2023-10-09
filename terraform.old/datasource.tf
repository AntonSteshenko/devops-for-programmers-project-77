data "digitalocean_ssh_key" "office_ssh_key" {
  name = "Lenovo"
}

data "digitalocean_ssh_key" "laptop_ssh_key" {
  name = "Laptop Lenovo"
}

data "digitalocean_domain" "default" {
  name = "rdas.site"
}

data "digitalocean_certificate" "test" {
  name = "test-cert"
}

data "digitalocean_database_cluster" "main" {
  name = "db-postgresql"
}

