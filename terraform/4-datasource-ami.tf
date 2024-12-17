# Get Latest AWS AMI ID for Debian
data "aws_ami" "debian" {
  most_recent = true
  owners = [ "136693071363" ] # ID du propriétaire officiel de l'AMI Debian

  filter {
    name = "name"
    values = [ "debian*" ]
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