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
        registry_url = "891377177922.dkr.ecr.us-west-1.amazonaws.com/ssgaikwad/emartnginx"
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

        stage (" mvn install") {
            steps {
                sh " cd javaapi && mvn install -DskipTests"
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
                    -Dsonar.java.binaries=javaapi/target/test-classes/com/springwork/bookwork/ \
                    -Dsonar.junit.reportsPath=javaapi/target/surefire-reports/'''
                }
            }               
        } 

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
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

        stage("REMOVE IMAGE") {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
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
