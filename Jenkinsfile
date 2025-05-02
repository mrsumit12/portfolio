pipeline {
    agent any

    environment {
        IMAGE_NAME      = 'sumit7372/portfolio'
        CONTAINER_NAME  = 'portfolio-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mrsumit12/portfolio.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d -p 3000:80 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! The portfolio container is up and running at port 3000.'
        }
        failure {
            echo '❌ Deployment failed! Check the console output for errors.'
        }
        always {
            echo '📦 CI/CD Pipeline execution completed.'
        }
    }
}
