# Create Ansible Security Group
resource "aws_security_group" "SSKEU1_ansible_sg" {
  name        = "SSKEU1-ansible-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSKEU1_ansible_sg"
  }
}

# Create docker Security Group
resource "aws_security_group" "SSKEU1_docker_sg" {
  name        = "SSKEU1_docker_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

 
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSKEU1_docker_sg"
  }
}



# Security group for Bastion Host
resource "aws_security_group" "SSKEU1_bastion_sg" {
  name        = "SSKEU1_bastion_sg"
  description = "Allow traffic for ssh"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ssh traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }

  tags = {
    Name = "SSKEU1_bastion_sg"
  }
}

resource "aws_security_group" "SSKEU1_jenkins_sg" {
  name        = "SSKEU1_jenkins_sg"
  description = "Allow Jenkins traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Proxy Traffic"
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SSKEU1_jenkins_sg"
  }
}




#creating docker lb security group 
resource "aws_security_group" "pacadeu1_docker_prod_lb_sg" {
  name        = "pacadeu1_docker_prod_lb_sg"
  description = "Allow Docker traffic"
  vpc_id      = var.vpc_id
  

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = data.aws_security_group.pacadeu1_docker_prod_lb_sg.id
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "pacadeu1_docker_prod_lb_sg"
  }
}
