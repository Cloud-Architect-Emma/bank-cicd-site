pipeline {
    agent any  // Ensure the agent has Docker installed

    environment {
        DOCKER_HUB_REPO = 'emma2323/bank-cicd-site'  // Updated to your Docker Hub username
        DOCKER_TAG = 'latest'  // Or use "${env.BUILD_NUMBER}" for versioning
        DOCKER_IMAGE = "${DOCKER_HUB_REPO}:${DOCKER_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Cloud-Architect-Emma/bank-cicd-site.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building project...'
                sh 'echo Build successful!'  // Replace with actual build commands if needed (e.g., npm install, mvn build)
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Build the Docker image
                    dockerImage = docker.build(DOCKER_IMAGE)
                    
                    // Login to Docker Hub and push using credentials
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-creds') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh 'echo Deployment successful!'  // Update with real deploy commands (e.g., kubectl apply -f deployment.yaml)
            }
        }
    }

    post {
        always {
            // Clean up local Docker images to free space
            sh "docker rmi ${DOCKER_IMAGE} || true"
        }
        success {
            echo 'Pipeline completed successfully! Image pushed to Docker Hub.'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
