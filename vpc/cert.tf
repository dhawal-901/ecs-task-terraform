data "aws_acm_certificate" "wildcard-test-dhawal-in-net" {
  domain   = local.Environment.cert_domain_name
  statuses = ["ISSUED"]
}

# resource "aws_acm_certificate" "cert-myapp-test" {
#   provider = aws.cdn-cert

#   domain_name       = local.Environment.cert_domain_name
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "cert-validation" {
#   provider                = aws.cdn-cert
#   certificate_arn         = aws_acm_certificate.cert-myapp-test.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert-validation-record : record.fqdn]

#   depends_on = [aws_route53_record.cert-validation-record]
# }


# resource "aws_route53_record" "cert-validation-record" {
#   provider = aws.cdn-cert
#   for_each = {
#     for dvo in aws_acm_certificate.cert-myapp-test.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.my-aws-project.zone_id

#   depends_on = [aws_acm_certificate.cert-myapp-test]
# }
