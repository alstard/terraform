terraform {
  required_version = "~> 0.11.2"

  # backend "local" {
  #   path = "local.tfstate"
  # }
}


provider "docker" {
  host    = "unix://localhost/var/run/docker.sock"
  version = "~> 0.1"
}

data "docker_registry_image" "ubuntu" {
  name = "rastasheep/ubuntu-sshd:14.04"
}

resource "docker_image" "ubuntu" { 
  keep_locally  = true
  name          = "${data.docker_registry_image.ubuntu.name}"
  pull_triggers = ["${data.docker_registry_image.ubuntu.sha256_digest}"]
}

resource "docker_container" "ubuntu" {
  image    = "${docker_image.ubuntu.name}"
  must_run = true
  name     = "ubuntu_container"

  ports {
    external = 2222
    internal = 22
  }
}