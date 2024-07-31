
output "docker_public_ip" {
  value = aws_instance.Docker_Main.private_ip
}

output "kubernetes_public_ip" {
  value = aws_instance.Kubernetes_Main.private_ip
}

output "jenkins_public_ip" {
  value = aws_instance.Jenkins_Main.private_ip
}