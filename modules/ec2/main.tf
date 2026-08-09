resource "aws_instance" "ec2_instance" {
  for_each               = var.instances
  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  tags                   = each.value.tags
}
