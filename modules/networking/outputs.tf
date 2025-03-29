output "vpc_id" {
  value       = aws_vpc.app_vpc.id
  description = "Output of VPC ID"
}

output "public_subnets" {
  value       = aws_subnet.public_subnet.*.id
  description = "Public Subnets"
}

output "public_subnet_cidr_block" {
  value       = aws_subnet.public_subnet.*.cidr_block
  description = "Public Subnet CIDR Block"
}

output "private_subnets" {
  value       = aws_subnet.private_subnet.*.id
  description = "Private Subnets"
}

output "private_subnet_cidr_block" {
  value       = aws_subnet.private_subnet.*.cidr_block
  description = "Private Subnet CIDR Block"
}
