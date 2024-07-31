provider "aws" {
  region = var.REGION
}

data "aws_secretsmanager_secret_version" "my_private_key_ansible" {
  secret_id = "MyAnsiblePrivateKey"
}

data "aws_secretsmanager_secret_version" "my_private_key_docker" {
  secret_id = "MyDockerPrivateKey"
}

data "aws_secretsmanager_secret_version" "my_private_key_kubernetes" {
  secret_id = "MyKubernetesPrivateKey"
}

data "aws_secretsmanager_secret_version" "my_private_key_jenkins" {
  secret_id = "MyJenkinsPrivateKey"
}

data "aws_secretsmanager_secret_version" "my_private_key_sonarqube" {
  secret_id = "MySonarqubePrivateKey"
}

terraform {
  backend "s3" {
    bucket = "project-emart"
    key    = "file/terraform.tfstate"
    region = "us-west-1"
  }
}
