output "sg_ec2_http_ssh_id" {
  value = aws_security_group.sg_ec2_http_ssh.id
}

output "sg_rds_mysql_id" {
  value = aws_security_group.sg_rds_mysql.id
}

output "sg_ec2_python_api_id" {
  value = aws_security_group.ec2_sg_python_api.id
}
