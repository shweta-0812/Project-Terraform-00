# main.tf file contains all resource and data source blocks

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }

    required_version = ">= 1.7"
  }
}

provider "docker" {
  host ="unix:///Users/shwetasingh/.docker/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "docker-nginx"

  ports {
    internal = 80
    external = 8000
  }
}
