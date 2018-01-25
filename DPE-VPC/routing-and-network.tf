# Declare the data source
data "aws_availability_zones" "available" {}

/* ROUTING, GW, ROUTE TABLES ETC... for the VPC - 'ATD-DPE-VPC' */
resource "aws_internet_gateway" "gw1" {
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
  tags {
    Name = "Internet GW provisioned by Terraform"
  }
}
resource "aws_network_acl" "allow-all" {
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
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
  }
}
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
  tags {
    Name = "Public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw1.id}"
  }
}
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
  tags {
    Name = "Private"
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