# output "Bastion IP" {
#   value = "${aws_instance.bastion1.public_ip}"
# }

# output "Bastion DNS" {
#   value = "${aws_instance.bastion1.public_dns}"
# }

output "Jumpbox IP" {
  value = "${aws_instance.atd-jumpbox1.public_ip}"
}
output "Jumpbox DNS Name" {
  value = "${aws_instance.atd-jumpbox1.public_dns}"
}
output "Jumpbox User" {
  value = "ec2-user"
}