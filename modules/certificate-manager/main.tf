resource "aws_acm_certificate" "devops_project_acm_arn" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "devops-prod"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.devops_project_acm_arn.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}
