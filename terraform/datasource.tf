data digitalocean_ssh_key "my_ssh_key" {
  name = "Lenovo"
}

data digitalocean_domain "default" {
  name = "rdas.site"
}

data digitalocean_certificate "test" {
  name = "test-cert"
}

data "digitalocean_database_cluster" "main" {
  name = "db-postgresql"
}