#create jenkins server 
resource "aws_instance" "SSKEU1_jenkins" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.SSKEU1pubsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.jenkins_sg]
  key_name                    = var.keypair
  
  user_data                   = local.jenkins_user_data

    tags = {
    Name = "SSKEU1_jenkins"
  }
}
