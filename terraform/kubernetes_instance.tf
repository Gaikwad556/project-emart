resource "aws_key_pair" "kubernetes_key" {
  key_name   = "kubernetes_key"
  public_key = file(var.KUBERNETES_KEY_PUB)
}

resource "aws_instance" "Kubernetes_Main" {
  ami               = var.AMI
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.kubernetes_key.key_name
  availability_zone = "us-west-1b"
  security_groups   = [aws_security_group.kubernetes_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id = aws_subnet.pub-sub-1.id

  provisioner "file" {
    source      = "kubernetes.sh"
    destination = "/home/ubuntu/kubernetes.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 770 /home/ubuntu/kubernetes.sh",
      "/home/ubuntu/kubernetes.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = data.aws_secretsmanager_secret_version.my_private_key_kubernetes.secret_string
    host        = self.public_ip
  }
  tags = {
    Name = "Kubernetes_Main"
  }
}

