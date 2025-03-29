resource "aws_db_subnet_group" "devops_project_db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_groups
}

resource "aws_db_instance" "devops_project_db_instance" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  identifier              = var.mysql_db_identifier
  username                = var.mysql_username
  password                = var.mysql_password
  skip_final_snapshot     = true
  db_name                 = var.mysql_dbname
  db_subnet_group_name    = aws_db_subnet_group.devops_project_db_subnet_group.name
  multi_az                = false
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
  vpc_security_group_ids  = [var.rds_mysql_sg_id]
}
