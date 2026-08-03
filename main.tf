
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  name       = var.project_name
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-igw"
}

module "subnets" {
  source                 = "./modules/subnets"
  vpc_id                 = module.vpc.vpc_id
  public_subnet_a_cidr   = var.public_subnet_a_cidr
  public_subnet_b_cidr   = var.public_subnet_b_cidr
  private_subnet_a_cidr  = var.private_subnet_a_cidr
  private_subnet_b_cidr  = var.private_subnet_b_cidr
  private_subnet_c_cidr  = var.private_subnet_c_cidr
  private_subnet_d_cidr  = var.private_subnet_d_cidr
  az_a                   = var.az_a
  az_b                   = var.az_b
}

module "elastic_ip" {
  source = "./modules/elastic_ip"
}

module "nat_gateway" {
  source            = "./modules/nat_gateway"
  nat_a_eip_id      = module.elastic_ip.nat_a_eip_id
   public_subnet_a_id = module.subnets.public_subnet_a_id
   public_subnet_b_id = module.subnets.public_subnet_b_id
   igw_dependency = module.igw.igw_id
}

module "route_table" {
  source               = "./modules/route_table"
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.igw.igw_id
   nat_gateway_a_id     = module.nat_gateway.nat_gateway_a_id
   public_subnet_a_id   = module.subnets.public_subnet_a_id
  public_subnet_b_id   = module.subnets.public_subnet_b_id
  private_subnet_a_id  = module.subnets.private_subnet_a_id
  private_subnet_b_id  = module.subnets.private_subnet_b_id
  private_subnet_c_id  = module.subnets.private_subnet_c_id
  private_subnet_d_id  = module.subnets.private_subnet_d_id
}

module "security_group_app" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  name        = "${var.project_name}-app-sg"
  description = "Security Group for ${var.project_name} app"
  ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },

  ]
  egress_rules  = [
    {
      description = "Allow all out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  tags         = []
}

module "security_group_app" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name = "${var.project_name}-alb-sg"
  description = "Security Group for Application Load Balancer"
  ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },

  ]
  egress_rules  = [
    {
      description = "Allow all out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  tags         = []
}

locals {
  instances = {
    app1 = {
      ami_id        = "ami-xxxxxx"
      instance_type = "t2.micro"
      subnet_id     = module.subnets.public_subnet_a_id
      security_group_ids = [module.security_group_app.security_group_id]
      tags = {
        Name = "MeuEc2InstanceApp1"
      }
    }
    app2 = {
      ami_id        = "ami-yyyyyy"
      instance_type = "t2.small"
      subnet_id     = module.subnets.public_subnet_b_id
      security_group_ids = [module.security_group_app.security_group_id]
      tags = {
        Name = "MeuEc2InstanceApp2"
      }
    }
  }
}

module "ec2_instances" {
  source = "./modules/ec2"
  instances = local.instances
}


module "alb" {
  source            = "./modules/alb"
  lb_name           = "${var.project_name}-alb"
  tg_name           = "${var.project_name}-tg"
  subnets_ids       = [module.subnets.public_subnet_a_id, module.subnets.public_subnet_b_id]
  vpc_id            = module.vpc.vpc_id
  security_group_ids = [module.security_group_app.security_group_id] 
  instances_id      = []
  tags              = {
    Project = var.project_name
  }
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-bucket-app"
  tags        = { Project = var.project_name }
}

module "ecr" {
  source   = "./modules/ecr"
  ecr_name = "${var.project_name}-app"
}
