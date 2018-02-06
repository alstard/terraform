
resource "aws_instance" "atd-app" {
  count                       = 3
  ami                         = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type               = "t2.micro"
  availability_zone           = "${element(var.ew2-azs, count.index)}"
  associate_public_ip_address = "false"
  subnet_id                   = "${element(aws_subnet.Private.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.atd-frontend.id}"]
  key_name                    = "${var.KeyPairName}"
  tags {
    Name                      = "atd-app-${count.index}"
    Purpose                   = "${var.purpose}"
    Owner                     = "${var.owner}"
  }
}

resource "aws_instance" "atd-db" {
  count                       = 3
  ami                         = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type               = "t2.micro"
  availability_zone           = "${element(var.ew2-azs, count.index)}"
  associate_public_ip_address = "false"
  subnet_id                   = "${element(aws_subnet.Private.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.atd-db.id}"]
  key_name                    = "${var.KeyPairName}"
  tags {
    Name                      = "atd-db-${count.index}"
    Purpose                   = "${var.purpose}"
    Owner                     = "${var.owner}"
  }
}

resource "aws_instance" "atd-jumpbox" {
  count                       = 1
  ami                         = "${lookup(var.ami-amazonlinux2, var.region)}"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = "${element(aws_subnet.Public.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.atd-jumpbox.*.id}"]
  key_name                    = "${var.KeyPairName}"
  tags {
    Name                      = "${var.jumpbox_name}-${count.index}"
    Purpose                   = "${var.purpose}"
    Owner                     = "${var.owner}"
  }
}
