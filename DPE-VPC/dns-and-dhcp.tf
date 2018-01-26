resource "aws_vpc_dhcp_options" "atd-dhcp" {
  domain_name = "${var.DNSZoneName}"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags {
    Name = "atddpe.local - Internal DNS Zone Name"
    Purpose = "Ansible Testing"
  }
}
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.atd-dhcp.id}"
}

/* DNS PART ZONE RECORDS */
resource "aws_route53_zone" "main" {
  name = "${var.DNSZoneName}"
  vpc_id = "${aws_vpc.atd-dpe-vpc.id}"
  comment = "Managed by Terraform"
}

resource "aws_route53_record" "database" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "atddb.${var.DNSZoneName}"
  type = "A"
  ttl = 300
  records = ["${aws_instance.atd-db1.private_ip}"]
}
