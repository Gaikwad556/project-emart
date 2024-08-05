pipeline {
    agent  any
    tools {
        jdk "jdk11"
        maven "mvn"
        nodejs "nodejs"
    }

    environment {
        aws_creds = "ecr:us-west-1:awscreds"
        image_name = "ssgaikwad/emartnginx"
        docker_hub = "dockerhub"
        registry_url = "891377177922.dkr.ecr.us-west-1.amazonaws.com/ssgaikwad/vprotomcatapp"
        project_url = "https://891377177922.dkr.ecr.us-west-1.amazonaws.com"
    }

    stages {

        stage ("git") {
            steps {
                git branch:'main',url:'https://github.com/Gaikwad556/project-emart.git'
            }
        }

        stage ("npm install") {
            steps {
                sh "cd client && rm -rf node_modules && npm cache clean --force && npm install"
            }
        } 

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'sonar4.7'
            }
            steps {
                    withSonarQubeEnv('sonar') { // If you have configured more than one global server connection, you can specify its name
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=emart \
                    -Dsonar.projectName=emart-repo-1 \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.inclusions=client/src/**/*.js,src/**/*.ts \
                    -Dsonar.exclusions=client/**/test/**,**/mock/**'''
                }
            }               
        } 

        stage ("docker build image "){
            steps {
                script {
                    dockerImage = docker.build("${image_name}:${BUILD_NUMBER}")
                }
            }
        }

        stage ("push image to docker "){
            steps {
                script {
                    docker.withRegistry(project_url,aws_creds) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage ("helm install"){
            agent {label 'KOPS'}
            steps {              
                sh "helm upgrade --install --force emart-stack helm/emartcharts --namespace prod --set appimage=${registry_url}:latest"             
            }
        }
    }
}