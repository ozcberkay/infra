terraform {
  backend "remote" {
    organization = "ozcberkay"
    workspaces {
      name = "infra"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.17.1"
    }
  }
}

variable "DO_FP" {
  #   sensitive = true
}
variable "DO_TOKEN" {
  #   sensitive = true
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

resource "digitalocean_droplet" "node" {
  image      = "ubuntu-20-04-x64"
  name       = "dev-1"
  region     = "fra1"
  size       = "s-1vcpu-1gb"
  tags       = ["dev"]
  monitoring = true
  ssh_keys = [
    var.DO_FP
  ]
}

output "ip" {
  value = digitalocean_droplet.node.ipv4_address
}
