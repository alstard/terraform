resource "aws_subnet" "Public" {
  count             = 1
  vpc_id            = "${aws_vpc.atd-dpe-vpc.id}"
  cidr_block        = "${lookup(var.public_cidr_blocks, count.index)}"
  availability_zone = "${lookup(var.availability_zones, count.index)}"
  tags {
    Name            = "Public Subnet"
    Purpose         = "Ansible Testing"
    Owner           = "atd"
  }
}

resource "aws_route_table_association" "Public" {
  subnet_id         = "${aws_subnet.Public.id}"
  route_table_id    = "${aws_route_table.Public.id}"
}

resource "aws_subnet" "Private" {
  count             = 3
  vpc_id            = "${aws_vpc.atd-dpe-vpc.id}"
  cidr_block        = "${lookup(var.private_cidr_blocks, count.index)}"
  availability_zone = "${lookup(var.availability_zones, count.index)}"
  tags {
    Purpose         = "Ansible Testing"
    Owner           = "atd"
    Name            = "Private-${count.index} Subnet"
  }
}

resource "aws_route_table_association" "Private" {
  count             = 3
  subnet_id         = "${element(aws_subnet.Private.*.id, count.index)}"
  route_table_id    = "${element(aws_route_table.Private.*.id, count.index)}"
}
