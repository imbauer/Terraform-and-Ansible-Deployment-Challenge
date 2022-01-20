resource "tls_private_key" "tadc_privatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tadc_keypair" {
  key_name   = "aws_key"
  public_key = tls_private_key.tadc_privatekey.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.tadc_privatekey.private_key_pem}' > ./aws_key.pem"
  }
}


# Create ec2 instance
resource "aws_instance" "tadc_ec2_instance" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t3.micro"
  key_name = aws_key_pair.tadc_keypair.key_name
  subnet_id = aws_subnet.tadc_public.id
  vpc_security_group_ids = [aws_security_group.nginx.id]

  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash

  set -ex
  sudo apt update && sudo apt upgrade -y
  sudo apt install nginx -y
  echo "<h1>Hello AcuityAds Devops Team! Here is the OS that this NGINX Service is currently running on ---> $(cat /etc/os-release | grep PRETTY)</h1>" >  /var/www/html/index.html
  systemctl enable nginx
  systemctl start nginx
  EOF


  tags = {
    Name = "tadc-ec2-instance"
  }
}

# Create elastic IP address for ec2 instance so that the IP address does not randomly change for the user
resource "aws_eip" "tadc_ip" {
  instance   = aws_instance.tadc_ec2_instance.id
  depends_on = [aws_instance.tadc_ec2_instance]
}

# Create 8GB volume
resource "aws_ebs_volume" "tadc_aws_ebs_volume" {
  availability_zone = "us-east-2a"
  size = 8

  tags = {
    Name = "tadc-ebs-volume"
  }
}

# Attach 8GB volume to ec2 instance
resource "aws_volume_attachment" "tadc_aws_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.tadc_aws_ebs_volume.id
  instance_id = aws_instance.tadc_ec2_instance.id
}
