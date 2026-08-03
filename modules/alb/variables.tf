variable "security_group_ids" {
  type    = list(string)
}

variable "subnets_ids" {
  type    = list(string)
}

variable "lb_name" {
    type = string
}

variable "tg_name" {
    type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "instances_id" {
  type = list(string)
}
