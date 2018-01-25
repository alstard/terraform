resource "aws_security_group" "ATD-FrontEnd" {
  name = "ATD-FrontEnd"
  tags {
    Name = "FrontEnd"
  }
  description = "ONLY ALLOWS HTTP CONNECTION INBOUND"
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ATD-DB" {
  name = "ATD-DB"
  tags {
    Name = "ATD-DB"
  }
  description = "ONLY ALLOWS TCP CONNECTION INBOUND"
  vpc_id = "${aws_vpc.ATD-DPE-VPC.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "TCP"
    # Restrict access to the FrontEnd
    security_groups = ["${aws_security_group.ATD-FrontEnd.id}"]
  }

  /* FOR DEBUG ONLY - CAN BE DELETED WHEN WORKING */
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /* END DEBUG */
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
