data "aws_route53_zone" "devops-project-zone" {
  name         = var.hosted_zone
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.devops-project-zone.id
  name    = var.host_fqdn
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}
