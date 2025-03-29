resource "aws_security_group" "sg_ec2_http_ssh" {
  name        = "ec2-allow-http-https-ssh"
  description = "Allow HTTP HTTPS and SSH traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow HTTP HTTPS and SSH"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ec2_http_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_http_ssh.id
}

resource "aws_security_group_rule" "ec2_https_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_http_ssh.id
}

resource "aws_security_group_rule" "ec2_ssh_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_http_ssh.id
}

resource "aws_security_group_rule" "ec2_outbound" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_http_ssh.id
}

resource "aws_security_group" "sg_rds_mysql" {
  name        = "rds-sg-db-port"
  description = "SG to allow access to mysql db port"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow access to mysql db port"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "rds_db_port_ingress" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.sg_ec2_http_ssh.id
  security_group_id        = aws_security_group.sg_rds_mysql.id
}

resource "aws_security_group" "ec2_sg_python_api" {
  name        = "python-api-sg"
  description = "SG to allow access to Python API"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow access to Python API"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group_rule" "python_api_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 5000
  to_port           = 5000
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg_python_api.id
}
