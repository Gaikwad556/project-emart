resource "aws_key_pair" "sonarqube_key" {
  key_name   = "sonarqube_key"
  public_key = file(var.SONARQUBE_KEY_PUB)
}

resource "aws_instance" "Sonarqube_Main" {
  ami               = var.AMI
  instance_type     = "t2.medium"
  key_name          = aws_key_pair.sonarqube_key.key_name
  availability_zone = "us-west-1b"
  security_groups   = [aws_security_group.sonarqube_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id = aws_subnet.pub-sub-1.id


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = data.aws_secretsmanager_secret_version.my_private_key_sonarqube.secret_string
    host        = self.public_ip
  }
  tags = {
    Name = "Sonarqube_Main"
  }
}

