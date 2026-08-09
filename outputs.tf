output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}
output "igw_id" {
  value = module.igw.igw_id
}
output "public_subnet_a_id" {
  value = module.subnets.public_subnet_a_id
}
output "public_subnet_b_id" {
  value = module.subnets.public_subnet_b_id
}
output "private_subnet_a_id" {
  value = module.subnets.private_subnet_a_id
}
output "private_subnet_b_id" {
  value = module.subnets.private_subnet_b_id
}
output "private_subnet_c_id" {
  value = module.subnets.private_subnet_c_id
}
output "private_subnet_d_id" {
  value = module.subnets.private_subnet_d_id
}
