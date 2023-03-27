# Vulnerable VM

resource "aws_vpc" "tfgoof_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Owner = var.owner
  }
}

resource "aws_subnet" "tfgoof_subnet" {
  vpc_id            = aws_vpc.tfgoof_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = var.primary_az

  tags = {
    Owner = var.owner
  }
}

resource "aws_network_interface" "tfgoof_interface" {
  subnet_id   = aws_subnet.tfgoof_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Owner = var.owner
  }
}

resource "aws_instance" "vuln_vm" {
  availability_zone = var.primary_az
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"
  user_data =  "${file("vuln_bootstrap.sh")}"
  network_interface {
    network_interface_id = aws_network_interface.tfgoof_interface.id
    device_index         = 0
  }

  tags = {
   Environment = "DEV"
   Owner = var.owner
  }
}


