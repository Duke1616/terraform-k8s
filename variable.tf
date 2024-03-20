# variable "traefik_config" {
#   type = any
#   default = {
#     hostname = "traefik.ebondhm.com"
#   }
#   description = "custom YAML values."
# }

variable "namespace" {
  type        = string
  default     = "traefik"
  description = "Name of the Kubernetes namespace where the Traefik deployment will be deployed."
}

variable "helm_traefik_version" {
  type        = string
  default     = "26.1.0"
  description = "Name of the Kubernetes namespace where the Traefik deployment will be deployed."
}
