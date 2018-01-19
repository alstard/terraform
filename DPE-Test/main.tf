provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

resource "aws_instance" "DPEATD1" {
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  security_groups = ["SG-DPEATD-DMZ"]
  key_name        = "atd-key-pair"

}

resource "aws_security_group" "SG-DPEATD-DMZ" {
  name = "SG-DPEATD-DMZ"
  description = "Allow http and ssh from everywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "SG-DPEATD-DMZ"
  }
}

output "ip" {
  value = "${aws_instance.DPEATD1.public_ip}"
}