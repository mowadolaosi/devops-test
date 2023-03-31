#create master server
resource "aws_instance" "SSKEU1_dockerblue" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.SSKEU1pubsub1_id
  vpc_security_group_ids      = [var.SSKEU1_docker_sg]
  key_name                    = var.keypair
  associate_public_ip_address = true
 
  tags = {
    Name = "SSKEU1_dockerblue"
  }
}

#create master2 server
resource "aws_instance" "SSKEU1_dockergreen" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.SSKEU1pubsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.SSKEU1_docker_sg]
  key_name                    = var.keypair
 
  tags = {
    Name = "SSKEU1_dockergreen"
  }
}