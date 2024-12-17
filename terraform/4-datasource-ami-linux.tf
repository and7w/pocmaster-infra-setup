# Get Latest AWS AMI ID for Debian
data "aws_ami" "awslinux" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "al2023-ami-*" ]
  }

  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}