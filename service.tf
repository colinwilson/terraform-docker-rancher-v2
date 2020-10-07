# Create Rancher 2 Docker service
resource "docker_service" "rancher2" {
  name = "rancher"

  task_spec {
    container_spec {
      image = "rancher/rancher:v2.4.8"
      args  = ["--no-cacerts"]

      labels {
        label = "traefik.enable"
        value = true
      }

      labels {
        label = "traefik.http.routers.rancher.rule"
        value = "Host(`${var.hostname}`)"
      }

      labels {
        label = "traefik.http.routers.rancher.entrypoints"
        value = "https"
      }

      labels {
        label = "traefik.http.services.rancher.loadbalancer.server.port"
        value = "80"
      }

      labels {
        label = "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto"
        value = "https"
      }

      labels {
        label = "traefik.http.routers.rancher.middlewares"
        value = "sslheader"
      }

      labels {
        label = "traefik.http.routers.rancher.tls.certresolver"
        value = "letsEncrypt"
      }

      mounts {
        source    = docker_volume.rancher_data_vol.name
        target    = "/var/lib/rancher"
        type      = "volume"
        read_only = false
      }
    }

    networks = var.networks
  }

  endpoint_spec {
    ports {
      target_port    = "80"
    }
    ports {
      target_port    = "443"
    }
  }
}
