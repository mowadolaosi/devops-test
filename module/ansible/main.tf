#create ansible server 
resource "aws_instance" "SSKEU1_ansible" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.SSKEU1pubsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ansible_sg]
  key_name                    = var.keypair
  iam_instance_profile = aws_iam_instance_profile.SSKEU1-IAM-profile.id
  user_data                   = local.ansible_user_data
  # Connection Through SSH
  connection {
    type        = "ssh"
    private_key = (var.prv_key)
    user        = "ubuntu"
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "../../modules/ansible/docker-image.yml"
    destination = "/opt/docker/docker-image.yml"
  }

  provisioner "file" {
    source      = "../../modules/ansible/docker-blue.yml"
    destination = "/opt/docker/docker-blue.yml"
  }
  provisioner "file" {
    source      = "../../modules/ansible/docker-green.yml"
    destination = "/opt/docker/docker-green.yml"
  }
  provisioner "file" {
    source      = "../../modules/ansible/ASG-container.yml"
    destination = "/opt/docker/ASG-container.yml"
  }

   provisioner "file" {
    source      = "../../modules/ansible/newrelic.yml"
    destination = "/opt/docker/newrelic.yml"
  }

    provisioner "file" {
    source      = "../../modules/ansible/autodiscovery.yml"
    destination = "/home/ubuntu/autodiscovery.yml"
  }


  tags = {
    Name = "SSKEU1_ansible"
  }
}