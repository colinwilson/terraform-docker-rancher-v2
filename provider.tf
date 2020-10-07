provider "docker" {
  # ensure your local (machine running Terraform) ~/.ssh/config specifies the correct host/key for authentication
  # See - https://github.com/terraform-providers/terraform-provider-docker/issues/268
  host = var.docker_host
}