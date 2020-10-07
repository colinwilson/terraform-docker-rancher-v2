# Required variables
variable "docker_host" {
  type        = string
  description = "Host URL for accessing Docker host via SSH e.g. ssh://root@my.docker,host:22"
}

variable "hostname" {
  type        = string
  description = "Hostname for accessing Rancher 2 e.g. rancher.example.com"
}

# Optional variables
variable "networks" {
  type        = list
  description = "List of networks to connect Rancher 2 to."
  default     = ["traefik"]
}