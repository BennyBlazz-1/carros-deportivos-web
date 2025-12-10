variable "project_name" {
  description = "Nombre del proyecto para nombrar recursos"
  type        = string
  default     = "carros-deportivos"
}

variable "location" {
  description = "Region de Azure"
  type        = string
  default     = "mexicocentral"
}

variable "docker_image" {
  description = "Imagen de Docker en Docker Hub"
  type        = string
  # EJEMPLO: "tuusuario/carros-deportivos:v1"
}

variable "mysql_admin" {
  description = "Usuario administrador de MySQL"
  type        = string
  default     = "admincarros"
}

variable "mysql_password" {
  description = "Password de MySQL (NO lo subas en claro a GitHub)"
  type        = string
  sensitive   = true
}
