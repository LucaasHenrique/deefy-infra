resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-a" }
}
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-b" }
}
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.az_a
  tags = { Name = "private-subnet-a" }
}
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.az_b
  tags = { Name = "private-subnet-b" }
}
resource "aws_subnet" "private_subnet_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_c_cidr
  availability_zone = var.az_a
  tags = { Name = "private-subnet-c" }
}
resource "aws_subnet" "private_subnet_d" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_d_cidr
  availability_zone = var.az_b
  tags = { Name = "private-subnet-d" }
}
