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

        // stage ("helm install"){
        //     agent {label 'KOPS'}
        //     steps {              
        //         sh "helm upgrade --install --force emart-stack helm/emartcharts --namespace prod --set appimage=$image_name:$BUILD_NUMBER"             
        //     }
        // }
    }
}