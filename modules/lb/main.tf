resource "aws_lb" "devops_project_lb" {
  name               = var.lb_name
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = [var.sg_enable_ssh_https]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "devops-project-lb"
  }
}

resource "aws_lb_listener" "devops_project_lb_listener" {
  load_balancer_arn = aws_lb.devops_project_lb.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener" "devops_project_lb_listener_https" {
  load_balancer_arn = aws_lb.devops_project_lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}
