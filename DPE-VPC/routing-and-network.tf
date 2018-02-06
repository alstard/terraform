# Declare the data source
data "aws_availability_zones" "available" {}

/* ROUTING, GW, ROUTE TABLES ETC... for the VPC - 'atd-dpe-vpc' */
resource "aws_internet_gateway" "IGW-1" {
  vpc_id        = "${aws_vpc.atd-dpe-vpc.id}"
  tags {
    Name        = "${var.internet-gw}"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
}

resource "aws_network_acl" "allow-all" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  egress {
    protocol    = "-1"
    rule_no     = 2
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }
  ingress {
    protocol    = "-1"
    rule_no     = 1
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }
  tags {
    Name            = "NACL - Allow All"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
}

resource "aws_route_table" "Public" {
  vpc_id        = "${aws_vpc.atd-dpe-vpc.id}"
  tags {
    Name        = "Public Route Table"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = "${aws_internet_gateway.IGW-1.id}"
  }
}

resource "aws_route_table" "Private" {
  count             = 3
  vpc_id            = "${aws_vpc.atd-dpe-vpc.id}"

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = "${aws_nat_gateway.Public.id}"
  }

  tags {
    Name            = "Private-${count.index} Route Table"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
}

resource "aws_eip" "forNat" {
  vpc = true
  
  tags {
    Name            = "atd-eip-fornat"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
}

resource "aws_nat_gateway" "Public" {
  allocation_id = "${aws_eip.forNat.id}"
  subnet_id = "${aws_subnet.Public.id}"
  depends_on = ["aws_internet_gateway.IGW-1"]
}

resource "aws_elb" "atd-elb-apptier" {
  name                = "${var.app-elb}"
  subnets             = ["${aws_subnet.Private.*.id}"]
  #security_groups    = ["${aws_security_group.atd-elb-apptier.id}"]
  #availability_zones = "${var.ew2-azs}"

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
    Name            = "${var.app-elb}"
    Purpose         = "${var.purpose}"
    Owner           = "${var.owner}"
  }
}