variable "db_username" {
  description = "Nome do usuário administrador do banco"
  type        = string
}
variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}
variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}
variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "subnets_id" {
    type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "identifier" {
  type = string
}
