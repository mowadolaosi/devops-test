# Create VPC
resource "aws_vpc" "SSKEU1_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "SSKEU1_vpc"
  }
}