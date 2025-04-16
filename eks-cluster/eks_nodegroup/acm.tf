resource "aws_acm_certificate" "cert" {
  domain_name               = "salilagrawal.com"
  subject_alternative_names = [
    "*.salilagrawal.com",
    "*.dev.salilagrawal.com",
  ]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Fetch DNS Validation Records from ACM
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if length(data.aws_route53_zone.public_zone.zone_id) > 0
  }

  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
  allow_overwrite = true // this will fix if record alredy exist


}

# Validate ACM Certificate
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
