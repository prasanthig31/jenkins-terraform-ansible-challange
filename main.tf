provider "aws" {
    region = var.region
}

# Amazon Linux Instance
resource "aws_instance" "amazon_linux_vm" {
  ami = var.ami_linux 
  instance_type = var.instance_type
  key_name = var.key_name

  tags = {
    Name = "c8.local" # Tag for the instance
  }
  # User Data to Set the Hostname
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname c8.local
              echo "127.0.0.1 c8.local" >> /etc/hosts
              EOF

  provisioner "local-exec" {
    command = <<EOT
      echo "[frontend]" >> inventory.yml
      echo "c8.local" >> inventory.yml
    EOT
  }
}

# Ubuntu Instance
resource "aws_instance" "ubuntu_vm" {
  ami = var.ami_ubuntu
  instance_type = var.instance_type
  key_name = var.key_name

  tags = {
    Name = "u21.local"
  }
  # User Data to Set the Hostname
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname u21.local
              echo "127.0.0.1 u21.local" >> /etc/hosts
              EOF
    provisioner "local-exec" {
    command = <<EOT
      echo "[backend]" >> inventory.yml
      echo "u21.local" >> inventory.yml
      echo "[all]" >> inventory.yml
      echo "u21.local ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/mum.pem" >> inventory.yml
      echo "c8.local ansible_user=ec2-user ansible_ssh_private_key_file=/root/.ssh/mum.pem" >> inventory.yml

    EOT
  }
}



# Output: Public IPs
output "instance_public_ips" {
  value = [
    aws_instance.amazon_linux_vm.public_ip,
    aws_instance.ubuntu_vm.public_ip
  ]
  description = "Public IPs of Amazon Linux and Ubuntu VMs"
}

