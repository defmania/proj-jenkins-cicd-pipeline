### ***PROJECT TO DEPLOY PYTHON FLASK API APP***

This project deploys infrastructure in AWS for running a Python Flask API app.

 --> It creates a VPC with subnets, route tables, internet gateway, security groups

 --> it creates an EC2 instance in your VPC in the and uses user data to git clone the app repo inside of the instance
 
 --> it creates an RDS MySQL database
 
 --> it creates a certificate in ACM to be used with our LB and an A record for your app FQDN in Route53 (in a hosted zone of your preference)
 
 --> it creates an Application Load Balancer and a Target Group which contains the created EC2 instance


### ***REPLACING PLACEHOLDERS AND VARIABLES***

In ./backend.tf make sure you fill in the details for the backend configuration you currently have:

 --> bucket name
 
 --> bucket key
 
 --> region
 
 --> dynamodb table name

In Jenkinsfile:

 --> replace <VAULT_SERVER>:<PORT> with your actual Vault config

In ./variables.tf make sure you replace/check values for:

 --> vpc_cidr (default 10.20.0.0/16) -> CIDR used by your VPC
 
 --> vpc_name (default my-app-project-vpc) -> name of VPC
 
 --> availability_zones (default set to us-east-1a, us-east-1b) -> AZs used by LB, EC2 instances, etc.
 
 --> cidr_private_subnet (default 10.20.1.0/24, 10.20.2.0/24) -> private subnet CIDRs
 
 --> cidr_public_subnet (default 10.20.3.0/24, 10.20.4.0/24) -> public subnet CIDRs
 
 --> public_key (currently pulled from Hashicorp Vault) -> used for SSH connection to EC2 instance
 
 --> db_username (currently pulled from Hashicorp Vault) -> MySQL username
 
 --> db_password (currently pulled from Hashicorp Vault) -> MySQL password
 
 --> db_identifier (default mysqldb) -> MySQL DB Identifier
 
 --> db_name (default projectdb) -> MySQL DB name
 
 --> lb_name (default my-project-lb) -> Load Balancer name
 
 --> domain_name (default app.mydomain.com) -> A record for your app
 
 --> db_subnet_group_name (default my_project_subnet_group) -> DB subnet group name
 
 --> lb_target_group_name (default my_project_target_group) -> Load balancer target group name
 
 --> instance_name (default app-node-01) -> EC2 instance name
 
 --> instance_type (default t2.micro) -> EC2 instance type
 
 --> app_port (default 5000) -> Port used by Python flask app
 
 --> enable_associate_public_ip_address -> Public IP association for instance
 
 --> hosted_zone -> your hosted zone in AWS. the hosted-zone module assumes you already have a hosted zone in your AWS account.

Used https://github.com/rahulwagh Jenkins project as a starting point, but made quite a few changes.
