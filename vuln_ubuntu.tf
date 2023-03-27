# Vulnerable VM
resource "aws_instance" "vuln_vm" {
  availability_zone = var.primary_az
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"
  key_name = var.key_name
 
  user_data =  "${file("vuln_bootstrap.sh")}"
  tags = {
   Environment = "DEV"
   Owner = var.owner

  }
}

# Unecrypted EBS
resource "aws_ebs_volume" "volume1" {
    availability_zone = var.primary_az
    size              = 40
    encrypted         = false
    tags = {
        Name = "${var.owner}-volume1"
        Owner = var.owner
    }
}



