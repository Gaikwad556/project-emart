variable "REGION" {
  default = "us-west-1"
}

variable "AMI" {
  default = "ami-0ff591da048329e00"
}

variable "ANSIBLE_KEY_PUB" {
  default = "keys/ansible_key.pub"
}

variable "DOCKER_KEY_PUB" {
  default = "keys/docker.pub"
}

variable "KUBERNETES_KEY_PUB" {
  default = "keys/kubernetes_key.pub"
}

variable "JENKINS_KEY_PUB" {
  default = "keys/jenkins_key.pub"
}

variable "SONARQUBE_KEY_PUB" {
  default = "keys/sonarqube.pub"
}