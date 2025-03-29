variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.20.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "my-app-project-vpc"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zone"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR Block"
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR Block"
  default     = ["10.20.3.0/24", "10.20.4.0/24"]
}

variable "public_key" {
  type        = string
  description = "Public Key used for EC2 instance"
}

variable "db_username" {
  type        = string
  description = "Database username"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "db_identifier" {
  type        = string
  description = "Database identifier"
  default     = "mysqldb"
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "projectdb"
}

variable "lb_name" {
  type        = string
  description = "Load Balancer name"
  default     = "my-project-lb"
}

variable "host_fqdn" {
  type        = string
  description = "value of host_fqdn including your hosted zone, format host.domain.com"
  default     = "app.mydomain.com"
}

variable "db_subnet_group_name" {
  type    = string
  default = "my_project_subnet_group"
}

variable "lb_target_group_name" {
  type    = string
  default = "my_project_target_group"
}

variable "instance_name" {
  type    = string
  default = "app-node-01"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "app_port" {
  type    = number
  default = 5000
}

variable "enable_associate_public_ip_address" {
  type    = bool
  default = true
}

variable "hosted_zone" {
  type    = string
  default = "myhostedzone.com"
}
