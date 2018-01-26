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