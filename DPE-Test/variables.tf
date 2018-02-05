variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}

variable "amis" {
  type = "map"
  default = {
    "eu-west-1" = "ami-4d46d534" # Ubuntu 16.04 LTS 
    "eu-west-2" = "ami-d7aab2b3" # Ubuntu 16.04 LTS 
  }
}