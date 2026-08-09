variable "vpc_cidr" {
  description = "CIDR principal da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Prefixo para nomeação"
  type        = string
  default     = "deefy"
}

variable "public_subnet_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  type    = string
  default = "10.0.4.0/24"
}

variable "private_subnet_c_cidr" {
  type    = string
  default = "10.0.5.0/24"
}

variable "private_subnet_d_cidr" {
  type    = string
  default = "10.0.6.0/24"
}

variable "az_a" {
  type    = string
  default = "us-east-1a"
}

variable "az_b" {
  type    = string
  default = "us-east-1b"
}


