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

variable "s3_bucket_arn" {
  type    = string
  default = null
}

variable "ecr_repository_arns" {
  type    = list(string)
  default = []
}

variable "role_name" {
  type = string
}
