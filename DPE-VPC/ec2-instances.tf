resource "aws_instance" "atd-app1" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-frontend.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-app1"
    Purpose = "Ansible Testing"
  }
}
resource "aws_instance" "atd-app2" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-frontend.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-app2"
    Purpose = "Ansible Testing"
  }
}
resource "aws_instance" "atd-db1" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-db.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-db1"
    Purpose = "Ansible Testing"
  }
}
resource "aws_instance" "atd-db2" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-db.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-db2"
    Purpose = "Ansible Testing"
  }
}
resource "aws_instance" "jumpbox1" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.jumpbox1.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "${var.jumpbox_name}"
    Purpose = "Ansible Testing"
  }
}


# resource "aws_instance" "bastion1" {
#   ami = "${lookup(var.ami-bastion, var.region)}"
#   instance_type = "t2.micro"
#   associate_public_ip_address = "true"
#   subnet_id = "${aws_subnet.PublicAZA.id}"
#   source_dest_check = "false"
#   vpc_security_group_ids = ["${aws_security_group.bastion1.id}"]
#   key_name = "${var.KeyPairName}"
#   tags {
#     Name = "${var.bastion_name}"
#     Purpose = "Ansible Testing"
#   }
# }
