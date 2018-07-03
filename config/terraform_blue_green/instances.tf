locals {

  user_data = <<EOF
    #cloud-config
    runcmd:
    - yum install -y docker
    - systemctl enable docker
    - systemctl start docker
    - docker run -d -p 80:80 nginx:latest
  EOF
}

resource "aws_instance" "terraform-blue-green" {
  count                  = 3
  ami                    = "ami-5d015622"
  instance_type          = "t2.micro"
#  subnet_id              = "${var.subnets, count.index}"
  subnet_id              = "${element(var.subnets, count.index)}"
#  vpc_security_group_ids = ["sg-25e8696e"]
  vpc_security_group_ids = "${var.security_groups}"
  key_name               = "opswerk"
  associate_public_ip_address = "True"

  user_data = "${local.user_data}"

  tags {
    Name                  = "Terraform Blue/Green ${count.index + 1} (v${var.infrastructure_version})"
    InfrastructureVersion = "${var.infrastructure_version}"
  }
}

output "instance_public_ips" {
  value = "${aws_instance.terraform-blue-green.*.public_ip}"
}
