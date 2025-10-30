pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Cloud-Architect-Emma/bank-cicd-site.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building project...'
                sh 'echo Build successful!'
            }
        }

        stage('Docker Build & Push') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t cloudarchitectemma/bank-cicd-site:latest .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh 'echo Deployment successful!'
            }
        }
    }
}
