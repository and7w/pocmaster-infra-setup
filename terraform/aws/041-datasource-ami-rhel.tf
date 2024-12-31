# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2-rhel" {
  most_recent = true
  owners = [ "309956199498" ]
  filter {
    name = "name"
    values = [ "RHEL-*_HVM-*-GP3" ]
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
