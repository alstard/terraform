  # resource "aws_subnet" "PublicAZA" {
  #   vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
  #   cidr_block = "${var.Subnet-Public-AzA-CIDR}"
  #   tags {
  #     Name = "PublicAZA"
  #   }
  #   availability_zone = "${data.aws_availability_zones.available.names[0]}"
  # }
  # resource "aws_route_table_association" "PublicAZA" {
  #   subnet_id = "${aws_subnet.PublicAZA.id}"
  #   route_table_id = "${route_table.public.id}"
  # }
  # resource "aws_subnet" "PrivateAZA" {
  #   vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"
  #   cidr_block = "${var.Subnet-Private-AzA-CIDR}"
  #   tags {
  #     Name = "PrivateAZA"
  #   }
  #   availability_zone = "${data.aws_availability_zones.available.names[0]}"
  # }
  # resource "aws_route_table_association" "PrivateAZA" {
  #   subnet_id = "${aws_subnet.PrivateAZA.id}"
  #   route_table_id = "${route_table.private.id}"
  # }