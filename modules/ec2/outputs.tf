output "ec2_instance_id" {
  value = aws_instance.devops_ec2_instance.id
}

output "public_ip" {
  value = aws_instance.devops_ec2_instance.public_ip
}
