pipeline {
    agent any

    environment {
        IMAGE_NAME = "portfolio-site"
        CONTAINER_NAME = "portfolio-container"
        GIT_URL = "https://github.com/mrsumit12/portfolio.git"
        DOCKER_HUB_REPO = "portfolio-repo"  // Replace with your actual Docker Hub repo name
    }

    stages {
        stage('Checkout') {
            steps {
                git url: GIT_URL, branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_HUB_REPO}:${BUILD_NUMBER} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${DOCKER_USERNAME}/${DOCKER_HUB_REPO}:${BUILD_NUMBER}"
            }
        }

        stage('Deploy Container') {
            steps {
                sh """
                   docker stop ${CONTAINER_NAME} || true
                   docker rm ${CONTAINER_NAME} || true
                   docker run -d -p 3000:80 --name ${CONTAINER_NAME} ${DOCKER_USERNAME}/${DOCKER_HUB_REPO}:${BUILD_NUMBER}
                """
            }
        }
    }

    post {
        success {
            echo "✅ Deployment complete"
        }
        failure {
            echo "❌ Build or deployment failed."
        }
    }
}
