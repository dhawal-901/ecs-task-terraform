data "aws_route53_zone" "my-aws-project" {
  name = local.Environment.hosted_zone
}

resource "aws_route53_record" "apache" {
  zone_id = data.aws_route53_zone.my-aws-project.zone_id
  name    = local.Environment.domain_name_1
  type    = "A"

  alias {
    name                   = aws_lb.my_lb.dns_name
    zone_id                = aws_lb.my_lb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "nginx" {
  zone_id = data.aws_route53_zone.my-aws-project.zone_id
  name    = local.Environment.domain_name_2
  type    = "A"

  alias {
    name                   = aws_lb.my_lb.dns_name
    zone_id                = aws_lb.my_lb.zone_id
    evaluate_target_health = false
  }
}
