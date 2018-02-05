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
  description = "Ubuntu AMI ID map for all eu-west regions"
}

variable "ami-amazonlinux" {
  type = "map"
  default = {
    "eu-west-1" = "ami-db1688a2" # Ireland
    "eu-west-2" = "ami-403e2524" # London
    "eu-west-3" = "ami-8ee056f3" # Paris
  }
  description = "Amazon Linux AMI ID map for all eu-west regions"
}

variable "ami-amazonlinux2" {
  type = "map"
  default = {
    "eu-west-1" = "ami-db1688a2" # Ireland
    "eu-west-2" = "ami-6d263d09" # London
    "eu-west-3" = "ami-5ce55321" # Paris
  }
  description = "Amazon Linux 2 AMI ID map for all eu-west regions"
}

variable "ami-bastion" {
  type = "map"
  default = {
    "eu-west-1" = "ami-a136a9d8" # Ireland
    "eu-west-2" = "ami-87312ae3" # London
    "eu-west-3" = "ami-0fe35572" # Paris
  }
  description = "AWS Marketplace Bastion h AMI ID map for all eu-west regions"
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
  default = "atd-jumpbox"
  description = "Name for the jumpbox security group and instance"
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

variable "availability_zones" {
  type = "map"
  default = {
    "0" = "eu-west-2a"
    "1" = "eu-west-2b"
    "2" = "eu-west-2c"
  }
  description = "Availability Zone names for the London region"
}

variable "private_cidr_blocks" {
  type = "map"
  default = {
    "0" = "172.17.1.0/24"
    "1" = "172.17.2.0/24"
    "2" = "172.17.3.0/24"
  }
  description = "CIDR blocks of the Public Subnet"
}

variable "public_cidr_blocks" {
  type = "map"
  default = {
    "0" = "172.17.0.0/24"
  }
  description = "CIDR blocks of the Public Subnet"
}

variable "ew2-azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "Subnet-Public-AzA-CIDR" {
  default = "172.17.0.0/24"
  description = "CIDR blocks of the Public Subnet"
}

variable "Subnet-Private-1-AzA-CIDR" {
  default = "172.17.1.0/24"
  description = "CIDR blocks of the Private Subnet #1"
}

variable "Subnet-Private-2-AzA-CIDR" {
  default = "172.17.2.0/24"
  description = "CIDR Block of the Private Subnet #2"
}

variable "app_server_http_port" {
  default     = "8080"
  description = "The port the instances will use for HTTP requests"
}

variable "app_server_https_port" {
  default     = "8443"
  description = "The port the instances will use for HTTPS requests"
}

# variable "URI" {
#   default     = "arn:aws:iam::123456789012:server-certificate/certName"
#   description = "The URI of the SSL Certificate to use for HTTPS connections"
# }

# variable bastion_name {
#   default = "bastion1"
#   description = "Name for the bastion host and security group"
# }
