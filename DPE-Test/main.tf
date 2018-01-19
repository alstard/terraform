provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.PSDDO1.id}"
}

resource "aws_instance" "PSDDO1" {
  # [Amazon Linux] ami           = "ami-d834aba1"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"

  # provisioner "local-exec" {
  #   command = "echo ${aws_instance.PSDDO1.public_ip} > ip_address.txt"
  # }
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}