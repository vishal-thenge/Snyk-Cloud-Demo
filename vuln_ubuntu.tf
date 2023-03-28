# Vulnerable VM
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "vuln_vm" {
  availability_zone = var.primary_az
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data =  "${file("vuln_bootstrap.sh")}"
  network_interface {
    network_interface_id = aws_network_interface.tfgoof_nic.id
    device_index         = 0
  }

  tags = {
   Environment = "DEV"
   Owner = var.owner
  }
}



#Build VPC
resource "aws_vpc" "tfgoofdemovpc" {
  cidr_block = var.aws_vpc_cidr
tags = {
    Owner = var.owner
  }
}

# Build Internet Gateway
resource "aws_internet_gateway" "tfgoof_demo_gateway" {
  vpc_id = aws_vpc.tfgoofdemovpc.id
  tags = {
    Owner = var.owner
  }
}


# Create a subnet
resource "aws_subnet" "external" {
  vpc_id                  = aws_vpc.tfgoofdemovpc.id
  cidr_block              = var.aws_subnet_cidr
  availability_zone       = var.primary_az
  tags = {
    Owner = var.owner
  }

}

#Create a Route Table
resource "aws_route_table" "tfgoof_route_table" {
  vpc_id = aws_vpc.tfgoofdemovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfgoof_demo_gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.tfgoof_demo_gateway.id
  }
  tags = {
    Owner = var.owner
  }

  }

#Associate Route Table to Subnet
resource "aws_route_table_association" "tfgoof_route_association" {
    subnet_id = aws_subnet.external.id
    route_table_id = aws_route_table.tfgoof_route_table.id
}


#Create security groups

resource "aws_security_group" "tfgoof_sg" {
  name = "${var.victim_company}-ssh-sg"
  vpc_id = aws_vpc.tfgoofdemovpc.id
ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.source_ip]
  }
ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.source_ip]
  }
ingress {
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = [var.source_ip]
  }
 ingress {
      from_port   = 1337
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = [var.source_ip]
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.source_ip]
  }

tags = {
    Owner = var.owner
  }

}


#Create Network Interface
resource "aws_network_interface" "tfgoof-nic" {
    subnet_id = aws_subnet.external.id
    private_ips = [var.tfgoof_private]
    security_groups = [aws_security_group.tfgoof_sg.id]
    tags = {
    Owner = var.owner
  }
}


#Create Elastic IP
resource "aws_eip" "tfgoof_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.tfgoof-nic.id
  associate_with_private_ip = var.tfgoof_private
  depends_on = [aws_internet_gateway.tfgoof_demo_gateway]

  tags = {
  Owner = var.owner
  }
}