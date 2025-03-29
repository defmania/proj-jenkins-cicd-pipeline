output "lb_dns_name" {
  value = aws_lb.devops_project_lb.dns_name
}

output "lb_zone_id" {
  value = aws_lb.devops_project_lb.zone_id
}
