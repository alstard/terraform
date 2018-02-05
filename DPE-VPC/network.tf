provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"

}

resource "aws_vpc" "atd-dpe-vpc" {
  cidr_block = "${var.VPC-fullcidr}"
  # Attributes below are necessary to utilise the internal VPC DNS resolution
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "atd-dpe-vpc"
    Environment = "Development"
    Purpose = "Ansible Testing"
    Owner = "atd"
  }
}
