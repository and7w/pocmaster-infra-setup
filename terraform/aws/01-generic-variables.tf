# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "ca-central-1"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business_divsion" {
  description = "Business Division"
  type = string
  default = "poc-master"
}

# KeyPair File
variable "keypair_file_path" {
  description = "SSH Key Pair file path"
  type = string
  default = "~/.ssh/key-terraform.pem"
}



