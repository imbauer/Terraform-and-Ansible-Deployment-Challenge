# Variables to configure in terraform.tfvars file
variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

# Already configured variables
variable "aws_region" {
  default = "us-east-2"
}