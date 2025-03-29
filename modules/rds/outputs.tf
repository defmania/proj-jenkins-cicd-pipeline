output "rds_endpoint" {
  value = aws_db_instance.devops_project_db_instance.address
}

output "db_name" {
  value = aws_db_instance.devops_project_db_instance.db_name
}
