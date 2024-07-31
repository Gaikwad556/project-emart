#!/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod 770 kubectl
sudo mv kubectl /usr/local/bin/kubectl

wget https://github.com/kubernetes/kops/releases/download/v1.26.4/kops-linux-amd64
sudo chmod 770 kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# to install kubeseal
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.1/kubeseal-0.18.1-linux-amd64.tar.gz
tar -xvzf kubeseal-0.18.1-linux-amd64.tar.gz
sudo mv kubeseal /usr/local/bin/
sudo chmod +x /usr/local/bin/kubeseal

# add label to node according to db_deploy file



# installing awscli
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.1/controller.yaml

# installing ingress
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml

# installing helm in kubernetes
curl -fsSL -o helm.tar.gz https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz  # Adjust the version and platform as needed
tar -zxvf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm


# To pull image from private ecr
# aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
# kubectl create secret docker-registry <secret_name> \
#   --docker-server=<aws_account_id>.dkr.ecr.<region>.amazonaws.com \
#   --docker-username=AWS \
#   --docker-password=$(aws ecr get-login-password --region <region>) \
#   --docker-email=your-email@example.com


# working with kubeseal 
#  helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
# helm install my-release sealed-secrets/sealed-secrets
# kubeseal --fetch-cert --controller-name my-release-sealed-secrets --controller-namespace <namespace>
# kubeseal --controller-name my-release-sealed-secrets --controller-namespace <namespace> --format yaml < secret.yaml > sealed-secret.yaml