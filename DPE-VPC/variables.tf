variable "region" {
  default = "eu-west-2"
}
variable "ami-ubuntu" {
  type = "map"
  default = {
    "eu-west-1" = "ami-4d46d534" # Ireland
    "eu-west-2" = "ami-d7aab2b3" # London
    "eu-west-3" = "ami-4262d53f" # Paris
  }
  description = "Added Ubuntu AMI ID for all eu-west regions"
}
variable "aws_access_key" {
  default = ""
  description = "AWS DPE Access Key for ATD"
}
variable "aws_secret_key" {
  default = ""
  description = "AWS DPE Secret Key for ATD"
}
variable "VPC-fullcidr" {
  default = "172.17.0.0/16"
  description = "Full CIDR Block of the VPC"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.17.0.0/24"
  description = "CIDR Block of the Public Subnet"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.17.1.0/24"
  description = "CIDR Block of the Private Subnet"
}
variable "KeyPairName" {
  default = ""
  description = "SSH Key to use for the EC2 Instances"
}
variable "DNSZoneName" {
  default = "atddpe.local"
  description = "Internal DNS Name to utilise for the VPC"
}