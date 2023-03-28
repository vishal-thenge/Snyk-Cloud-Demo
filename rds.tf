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
  db_subnet_group_name = "${aws_db_subnet_group.validsubnetgroup.id}"
  skip_final_snapshot = true
}
