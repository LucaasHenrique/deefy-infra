resource "aws_eip" "nat_a" {
  domain = "vpc"
  tags = { Name = "nat-eip-a" }
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
  tags = { Name = "nat-eip-b" }
}
