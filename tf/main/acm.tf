resource "aws_acm_certificate" "somtum_dot_io" {
  domain_name       = "*.somtum.io"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "aws_acm_certificate_somtum_dot_io_domain_validation_options" {
  value = aws_acm_certificate.somtum_dot_io.domain_validation_options
}

# how to complete certificate validation on GoDaddy - https://stackoverflow.com/questions/49488095/validating-domain-for-aws-acm-in-godaddy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
