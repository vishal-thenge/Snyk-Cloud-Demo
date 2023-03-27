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

