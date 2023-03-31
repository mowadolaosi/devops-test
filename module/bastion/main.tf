resource "aws_instance" "Bastion_Host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.SSKEU1pubsub1_id
  key_name                    = var.keypair
  vpc_security_group_ids      = [var.bastion_sg]
  associate_public_ip_address = true
  user_data = <<-EOF
#!/bin/bash
echo "${var.prv_key}" >> /home/ubuntu/SSKEU1_prv
sudo chmod 400 SSKEU1_prv
sudo hostnamectl set-hostname Bastion
EOF
  tags = {
    Name = "Bastion_Host"
  }
}