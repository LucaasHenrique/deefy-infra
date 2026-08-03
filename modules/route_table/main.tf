resource "aws_route_table" "public_rt_a" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = var.igw_id
  }
  tags = { Name = "public-rt-a" }
}
resource "aws_route_table" "public_rt_b" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = var.igw_id
  }
  tags = { Name = "public-rt-b" }
}
resource "aws_route_table" "private_rt_a" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_a_id
  }
  tags = { Name = "private-rt-a" }
}
resource "aws_route_table" "private_rt_b" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_a_id
  }
  tags = { Name = "private-rt-b" }
}

resource "aws_route_table_association" "public_rt_a" {
  route_table_id = aws_route_table.public_rt_a.id
  subnet_id      = var.public_subnet_a_id
}
resource "aws_route_table_association" "public_rt_b" {
  route_table_id = aws_route_table.public_rt_b.id
  subnet_id      = var.public_subnet_b_id
}
resource "aws_route_table_association" "private_rt_a" {
  route_table_id = aws_route_table.private_rt_a.id
  subnet_id      = var.private_subnet_a_id
}
resource "aws_route_table_association" "private_rt_b" {
  route_table_id = aws_route_table.private_rt_b.id
  subnet_id      = var.private_subnet_b_id
}
resource "aws_route_table_association" "private_rt_c" {
  route_table_id = aws_route_table.private_rt_a.id
  subnet_id      = var.private_subnet_c_id
}
resource "aws_route_table_association" "private_rt_d" {
  route_table_id = aws_route_table.private_rt_b.id
  subnet_id      = var.private_subnet_d_id
}
