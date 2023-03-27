#Company Name
variable "victim_company" {
  type        = string
  description = "For naming purposes"
  default     = "goofdemo"
}

#Owner CHANGE THIS
variable "owner" {
  type        = string
  description = "For Tagging and Filtering purposes"
  default     = "Patch"
}

#AWS Region
variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

#AWS AZ
variable "primary_az" {
  description = "primary AZ"
  default     = "us-east-2a"
}

#AMI - You must adjust this based on the region you're in
variable "ubuntu_ami" {
  default = "ami-05803413c51f242b7"
}


#Key Pair Name
variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "goofkey"
}

