output "ec2_instance_id" {
  value = { for k, v in aws_instance.ec2_instance : k => v.id }
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2.name
}

output "ec2_role_name" {
  value = aws_iam_role.ec2.name
}
