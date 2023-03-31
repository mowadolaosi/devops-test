locals {
  ansible_user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt update -y
sudo apt install ansible -y
sudo hostnamectl set-hostname ansible
sudo apt install python3-pip -y
ansible-galaxy collection install amazon.aws
pip install boto3
sudo apt install docker.io -y
sudo mkdir /opt/docker
sudo chown -R ubuntu:ubuntu /opt/docker
sudo chmod -R  700 /opt/docker
sudo chmod 700 /home/ubuntu/.ssh/authorized_keys
sudo chmod -R 700 .ssh/
sudo chown -R ubuntu:ubuntu .ssh/
sudo bash -c ' echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
echo "${var.prv_key}" >> /home/ubuntu/.ssh/sock-key
sudo chmod 400 sock-key
sudo chmod -R 700 .ssh/
cat <<EOT>> /etc/ansible/hosts
localhost ansible_connection=local
[docker_blue]
${var.dockerblueIP} ansible_ssh_private_key_file=/home/ubuntu/.ssh/sock-key
[docker_green]
${var.dockergreenIP} ansible_ssh_private_key_file=/home/ubuntu/.ssh/sock-key
EOT

sudo echo "*/15 * * * * ubuntu ansible-playbook -i /etc/ansible/hosts /opt/docker/Autodiscovery.yml >> /opt/docker/autodiscovery.log" >> /etc/crontab
EOF
}

