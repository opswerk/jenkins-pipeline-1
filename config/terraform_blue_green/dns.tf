data "aws_route53_zone" "terraform-blue-green" {
  name = "opswerk.com."
}

resource "aws_route53_record" "terraform-blue-green" {
  zone_id = "${data.aws_route53_zone.terraform-blue-green.zone_id}"
  name    = "v${var.infrastructure_version}.opswerk.com"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_elb.terraform-blue-green.dns_name}"
    zone_id                = "${aws_elb.terraform-blue-green.zone_id}"
    evaluate_target_health = false
  }
}
