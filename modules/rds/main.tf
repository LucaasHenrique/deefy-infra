resource "aws_db_subnet_group" "this" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnets_id 
}

resource "aws_db_instance" "main" {
  identifier              = var.identifier
  engine                  = "postgres" 
  instance_class          = var.db_instance_class
  allocated_storage       = 20
  storage_type            = "gp3"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids 
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  multi_az                = true        
  storage_encrypted       = true
  deletion_protection     = false
  backup_retention_period = 0
  skip_final_snapshot     = true 
  apply_immediately       = true
  tags = {
    Name        = "deefy-rds-prod"
    Environment = "prod"
  }
}
