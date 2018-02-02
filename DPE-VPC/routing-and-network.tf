# Declare the data source
data "aws_availability_zones" "available" {}

/* ROUTING, GW, ROUTE TABLES ETC... for the VPC - 'atd-dpe-vpc' */
resource "aws_internet_gateway" "gw1" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  tags {
    Name = "Internet GW provisioned by Terraform"
    Purpose = "Ansible Testing"
  }
}
resource "aws_network_acl" "allow-all" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  egress {
    protocol = "-1"
    rule_no = 2
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  tags {
    Name = "NACL - OPEN TO ALL"
    Purpose = "Ansible Testing"
  }
}
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  tags {
    Name = "Public"
    Purpose = "Ansible Testing"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw1.id}"
  }
}
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  tags {
    Name = "Private"
    Purpose = "Ansible Testing"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.PublicAZA.id}"
  }
}
resource "aws_eip" "forNat" {
  vpc = true
}
resource "aws_nat_gateway" "PublicAZA" {
  allocation_id = "${aws_eip.forNat.id}"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  depends_on = ["aws_internet_gateway.gw1"]
}

resource "aws_elb" "atd-elb-apptier" {
  name               = "atd-elb-apptier"
  availability_zones = "${var.ew2-azs}"
  security_groups    = ["${aws_security_group.atd-elb-apptier.id}"]

  listener {
    instance_port     = "${var.app_server_http_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # listener {
  #   instance_port      = "${var.app_server_https_port}"
  #   instance_protocol  = "https"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = "${aws_iam_server_certificate.atd_iam_server_cert.id}"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  instances                   = ["${aws_instance.atd-app.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "atd-elb-apptier"
    Purpose = "Ansible Testing"
    Owner = "atd"
  }
}