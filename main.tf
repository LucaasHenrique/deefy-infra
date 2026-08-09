// vpc block 
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  name       = var.project_name
}

// igw block 
module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-igw"
}

// subnets block 
module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  private_subnet_c_cidr = var.private_subnet_c_cidr
  private_subnet_d_cidr = var.private_subnet_d_cidr
  az_a                  = var.az_a
  az_b                  = var.az_b
}

// elastic ip block 
module "elastic_ip" {
  source = "./modules/elastic_ip"
}

// nat block 
module "nat_gateway" {
  source             = "./modules/nat_gateway"
  nat_a_eip_id       = module.elastic_ip.nat_a_eip_id
  public_subnet_a_id = module.subnets.public_subnet_a_id
  public_subnet_b_id = module.subnets.public_subnet_b_id
  igw_dependency     = module.igw.igw_id
}

// route table block 
module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.igw.igw_id
  nat_gateway_a_id    = module.nat_gateway.nat_gateway_a_id
  public_subnet_a_id  = module.subnets.public_subnet_a_id
  public_subnet_b_id  = module.subnets.public_subnet_b_id
  private_subnet_a_id = module.subnets.private_subnet_a_id
  private_subnet_b_id = module.subnets.private_subnet_b_id
  private_subnet_c_id = module.subnets.private_subnet_c_id
  private_subnet_d_id = module.subnets.private_subnet_d_id
}

// sg block 
module "security_group_app" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  name        = "${var.project_name}-app-sg"
  description = "Security Group for ${var.project_name} app"
  ingress_rules = [
    {
      description     = "Allow HTTP from ALB"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      security_groups = [module.security_group_app_alb.app_sg_id]
    },
    {
      description     = "Allow HTTPS from ALB"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      security_groups = [module.security_group_app_alb.app_sg_id]
    },

  ]
  egress_rules = [
    {
      description = "Allow all out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  tags = {}
}

module "security_group_app_alb" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  name        = "${var.project_name}-alb-sg"
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
  egress_rules = [
    {
      description = "Allow all out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  tags = {}
}

module "security_group_app_rds" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  name        = "${var.project_name}-rds-sg"
  description = "Security Group for RDS"
  ingress_rules = [
    {
      description     = "Allow Postgres Port"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [module.security_group_app.app_sg_id]
    },
  ]
  egress_rules = [
    {
      description = "Allow all out"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  tags = {}
}

// s3 block 
module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-bucket-app"
  tags        = { Project = var.project_name }
}

// ecr block 
module "ecr" {
  source   = "./modules/ecr"
  ecr_name = "${var.project_name}-app"
}

// ec2 block
locals {
  instances = {
    prod-1 = {
      ami_id             = "ami-0bdc7d025135d7b49"
      instance_type      = "t3.micro"
      subnet_id          = module.subnets.private_subnet_a_id
      security_group_ids = [module.security_group_app.app_sg_id]
      tags = {
        Name        = "deefy-prod-1"
        Environment = "production"
        Purpose     = "app-server-prod"
      }
    }
    prod-2 = {
      ami_id             = "ami-0bdc7d025135d7b49"
      instance_type      = "t3.micro"
      subnet_id          = module.subnets.private_subnet_b_id
      security_group_ids = [module.security_group_app.app_sg_id]
      tags = {
        Name        = "deefy-prod-2"
        Environment = "production"
        Purpose     = "app-server-prod"
      }
    }
    prod-3 = {
      ami_id             = "ami-0bdc7d025135d7b49"
      instance_type      = "t3.micro"
      subnet_id          = module.subnets.private_subnet_a_id
      security_group_ids = [module.security_group_app.app_sg_id]
      tags = {
        Name        = "deefy-prod-3"
        Environment = "production"
        Purpose     = "app-server-prod"
      }
    }
    test-1 = {
      ami_id             = "ami-0bdc7d025135d7b49"
      instance_type      = "t3.micro"
      subnet_id          = module.subnets.private_subnet_b_id
      security_group_ids = [module.security_group_app.app_sg_id]
      tags = {
        Name        = "deefy-test-1"
        Environment = "test"
        Purpose     = "app-server-test"
      }
    }
  }
}

module "ec2_instances" {
  source              = "./modules/ec2"
  instances           = local.instances
  role_name           = var.project_name
  s3_bucket_arn       = module.s3.bucket_arn
  ecr_repository_arns = [module.ecr.repository_arn]
}

// alb block 
module "alb" {
  source             = "./modules/alb"
  lb_name            = "${var.project_name}-alb"
  tg_name            = "${var.project_name}-tg"
  subnets_ids        = [module.subnets.public_subnet_a_id, module.subnets.public_subnet_b_id]
  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.security_group_app_alb.app_sg_id]
  instances_id       = values(module.ec2_instances.ec2_instance_id)
  tags = {
    Project = var.project_name
  }
}

// rds block
data "aws_secretsmanager_secret" "rds" {
  name = "prod/postgresql"
}

data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}

module "rds_postgres" {
  source             = "./modules/rds"
  subnets_id         = [module.subnets.private_subnet_c_id, module.subnets.private_subnet_d_id]
  security_group_ids = [module.security_group_app_rds.app_sg_id]
  db_username        = local.rds_credentials.username
  db_password        = local.rds_credentials.password
  db_name            = var.project_name
  identifier         = "${var.project_name}-rds"
}
