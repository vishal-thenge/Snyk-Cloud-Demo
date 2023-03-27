# Vulnerable VM
resource "aws_instance" "vuln_vm" {
  availability_zone = var.primary_az
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"
  user_data =  "${file("vuln_bootstrap.sh")}"
  tags = {
   Environment = "DEV"
   Owner = var.owner

  }
}


