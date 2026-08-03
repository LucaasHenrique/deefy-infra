resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = var.nat_a_eip_id
  subnet_id     = var.public_subnet_a_id
  tags = { Name = "gw-NAT-A" }
  depends_on = [var.igw_dependency]
}


