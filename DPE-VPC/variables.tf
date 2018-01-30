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

variable "ami-amazonlinux" {
  type = "map"
  default = {
    "eu-west-1" = "ami-db1688a2" # Ireland
    "eu-west-2" = "ami-403e2524" # London
    "eu-west-3" = "ami-8ee056f3" # Paris
  }
}

variable "ami-amazonlinux2" {
  type = "map"
  default = {
    "eu-west-1" = "ami-db1688a2" # Ireland
    "eu-west-2" = "ami-6d263d09" # London
    "eu-west-3" = "ami-5ce55321" # Paris
  }
}

variable "ami-bastion" {
  type = "map"
  default = {
    "eu-west-1" = "ami-a136a9d8" # Ireland
    "eu-west-2" = "ami-87312ae3" # London
    "eu-west-3" = "ami-0fe35572" # Paris
  }
}

variable "aws_access_key" {
  default = ""
  description = "AWS DPE Access Key"
}

variable "aws_secret_key" {
  default = ""
  description = "AWS DPE Secret Key"
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
  default = "atd-dpe-ew2-keypair"
  description = "SSH Key to use for the EC2 Instances"
}

variable "DNSZoneName" {
  default = "atddpe.local"
  description = "Internal DNS Name to utilise for the VPC"
}

variable jumpbox_name {
  default = "atd-jumpbox1"
  description = "Name for the jumpbox security group and instance"
}

# variable bastion_name {
#   default = "bastion1"
#   description = "Name for the bastion host and security group"
# }