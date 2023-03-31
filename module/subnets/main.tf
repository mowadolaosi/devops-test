# Create Public Subunet 1
resource "aws_subnet" "SSKEU1_pub_sn1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.SSKEU1pubsub1_cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "SSKEU1_pub_sn1"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "SSKEU1_pub_sn2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.SSKEU1pubsub2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "SSKEU1_pub_sn2"
  }
}

# Create Private Subnet 1
resource "aws_subnet" "SSKEU1_prv_sn1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.SSKEU1prvsub1_cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "SSKEU1_prv_sn1"
  }
}

# Create Private Subnet 2
resource "aws_subnet" "SSKEU1_prv_sn2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.SSKEU1prvsub2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "SSKEU1_prv_sn2"
  }
}

# Craete Internet Gateway
resource "aws_internet_gateway" "SSKEU1_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "SSKEU1_igw"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "SSKEU1_nat_eip" {
  vpc = true

  tags = {
    Name = "SSKEU1_nat_eip"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "SSKEU1_ngw" {
  allocation_id = aws_eip.SSKEU1_nat_eip.id
  subnet_id     = aws_subnet.SSKEU1_pub_sn1.id

  tags = {
    Name = "SSKEU1_ngw"
  }
  # Explicit Dependency
  depends_on = [aws_internet_gateway.SSKEU1_igw]
}

# Create Route-Table for Public Subnet
resource "aws_route_table" "SSKEU1_pub_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.all_ip
    gateway_id = aws_internet_gateway.SSKEU1_igw.id
  }
}

# Create Route-Table for Private Subnet
resource "aws_route_table" "SSKEU1_prv_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.all_ip
    nat_gateway_id = aws_nat_gateway.SSKEU1_ngw.id
  }
}

# Create Route-Table Association for Public Subnet 1
resource "aws_route_table_association" "SSKEU1_pub_sub_rt_as1" {
  subnet_id      = aws_subnet.SSKEU1_pub_sn1.id
  route_table_id = aws_route_table.SSKEU1_pub_rt.id
}
# Create Route-Table Association for Public Subnet 2
resource "aws_route_table_association" "SSKEU1_pub_sub_rt_as2" {
  subnet_id      = aws_subnet.SSKEU1_pub_sn2.id
  route_table_id = aws_route_table.SSKEU1_pub_rt.id
}

# Create Route-Table Association for Private Subnet 1
resource "aws_route_table_association" "SSKEU1_prv_sub_rt_as1" {
  subnet_id      = aws_subnet.SSKEU1_prv_sn1.id
  route_table_id = aws_route_table.SSKEU1_prv_rt.id
}

# Create Route-Table Association for Private Subnet 2
resource "aws_route_table_association" "SSKEU1_prv_sub_rt_as2" {
  subnet_id      = aws_subnet.SSKEU1_prv_sn2.id
  route_table_id = aws_route_table.SSKEU1_prv_rt.id
}