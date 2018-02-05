resource "aws_security_group" "atd-frontend" {
  name = "atd-frontend"
  tags {
    Name = "frontend"
    Purpose = "Ansible Testing"
  }
  description = "ONLY ALLOWS HTTP/HTTPS CONNECTION INBOUND"
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "TCP"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["${var.Subnet-Public-AzA-CIDR}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "atd-db" {
  name = "atd-db"
  tags {
    Name = "atd-db"
    Purpose = "Ansible Testing"
  }
  description = "ONLY ALLOWS TCP CONNECTION INBOUND"
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "TCP"
    # Restrict access to the FrontEnd
    security_groups = ["${aws_security_group.atd-frontend.id}"]
  }

  /* FOR DEBUG ONLY - CAN BE DELETED WHEN WORKING */
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "TCP"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["${var.Subnet-Public-AzA-CIDR}"]
  }
  /* END DEBUG */
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "bastion1" {
#   name        = "${var.bastion_name}"
#   vpc_id      = "${aws_vpc.atd-dpe-vpc.id}"
#   description = "Bastion security group"
#   ingress {
#     protocol    = -1
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["${var.VPC-fullcidr}"]
#   }
#   ingress {
#     protocol    = "tcp"
#     from_port   = 22
#     to_port     = 22
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     protocol    = -1
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags {
#     Name = "${var.bastion_name}"
#     Purpose = "Ansible Testing"
#   }
# }

resource "aws_security_group" "atd-jumpbox" {
  name        = "${var.jumpbox_name}"
  vpc_id      = "${aws_vpc.atd-dpe-vpc.id}"
  description = "Security Group for ATD Jumpbox"

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

  tags {
    Name = "${var.jumpbox_name}"
    Purpose = "Ansible Testing"
  }
}

# resource "aws_security_group" "atd-elb-apptier" {
#   name        = "atd-elb-apptier"
#   vpc_id      = "${aws_vpc.atd-dpe-vpc.id}"
#   description = "Security Group for ATD Load Balancer - App Tier"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags {
#     Name    = "atd-elb-apptier"
#     Purpose = "Ansible Testing"
#     Owner   = "atd" 
#   }
# }