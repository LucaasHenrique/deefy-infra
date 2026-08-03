variable "ami_id" {
  type    = string
}

variable "subnet_id" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "vpc_security_group_ids" {
  type    = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "instances" {
  description = "Mapeamento de instâncias EC2"
  type = map(object({
    ami_id              = string
    instance_type       = string
    subnet_id           = string
    security_group_ids  = list(string)
    tags                = map(string)
  }))
}
