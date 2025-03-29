output "vpc_id" {
  value       = module.networking.vpc_id
  description = "VPC id"
}

output "ec2_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP address of EC2 instance"
}

output "ec2_instance_id" {
  value       = module.ec2.ec2_instance_id
  description = "EC2 instance ID"
}

output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  description = "RDS endpoint for connecting to the database"
}

output "db_name" {
  value       = module.rds.db_name
  description = "Database name"
}
