resource "aws_instance" "atd-app" {
  count = 2
  ami = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type = "t2.micro"
  availability_zone = "${element(var.ew2-azs, count.index)}"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-frontend.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-app-${count.index}"
    Purpose = "Ansible Testing"
    Owner = "atd"
  }
}

# resource "aws_instance" "atd-app2" {
#   ami = "${lookup(var.ami-amazonlinux2, var.region)}"
#   instance_type = "t2.micro"
#   associate_public_ip_address = "true"
#   subnet_id = "${aws_subnet.PublicAZA.id}"
#   vpc_security_group_ids = ["${aws_security_group.atd-frontend.id}"]
#   key_name = "${var.KeyPairName}"
#   tags {
#     Name = "atd-app2"
#     Purpose = "Ansible Testing"
#   }
# }

resource "aws_instance" "atd-db" {
  count = 2
  ami = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type = "t2.micro"
  availability_zone = "${element(var.ew2-azs, count.index)}"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-db.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "atd-db-${count.index}"
    Purpose = "Ansible Testing"
    Owner = "atd"
  }
}
# resource "aws_instance" "atd-db2" {
#   ami = "${lookup(var.ami-amazonlinux2, var.region)}"
#   instance_type = "t2.micro"
#   associate_public_ip_address = "false"
#   subnet_id = "${aws_subnet.PrivateAZA.id}"
#   vpc_security_group_ids = ["${aws_security_group.atd-db.id}"]
#   key_name = "${var.KeyPairName}"
#   tags {
#     Name = "atd-db2"
#     Purpose = "Ansible Testing"
#   }
# }

resource "aws_instance" "atd-jumpbox" {
  count = 1
  ami = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.atd-jumpbox.*.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "${var.jumpbox_name}-${count.index}"
    Purpose = "Ansible Testing"
    Owner = "atd"
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
