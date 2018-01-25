resource "aws_instance" "ATD-APP1" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.medium"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.ATD-FrontEnd.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "ATD-APP1"
  }
}
resource "aws_instance" "ATD-APP2" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.medium"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.ATD-FrontEnd.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "ATD-APP2"
  }
}
resource "aws_instance" "ATD-DB1" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.medium"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.ATD-DB.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "ATD-DB1"
  }
}
resource "aws_instance" "ATD-DB2" {
  ami = "${lookup(var.ami-ubuntu, var.region)}"
  instance_type = "t2.medium"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.ATD-DB.id}"]
  key_name = "${var.KeyPairName}"
  tags {
    Name = "ATD-DB2"
  }
}