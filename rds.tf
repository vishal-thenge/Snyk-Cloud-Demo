resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "standard"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydbvalid"
  username             = "validpublic"
  password             = "SecretPassw0rd"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  db_subnet_group_name = "${aws_db_subnet_group.tfgoof_subnet_group.id}"
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "tfgoof_subnet_group" {
  name       = "${var.victim_company}-subnet-group"
  subnet_ids = [aws_subnet.external_db.id, aws_subnet.internal_db.id]

  tags = {
    Owner = var.owner
  }
}


resource "aws_vpc" "tfgoofdbvpc" {
tags = {
    Owner = var.owner
  }
}

resource "aws_subnet" "external_db" {
  vpc_id                  = aws_vpc.tfgoofdbvpc.id
  tags = {
    Owner = var.owner
  }

}

resource "aws_subnet" "internal_db" {
  vpc_id                  = aws_vpc.tfgoofdbvpc.id
  tags = {
    Owner = var.owner
  }

}