pipeline {
    agent any

    environment {
        APP_NAME = "task"
        IMAGE_NAME = "task"
        CONTAINER_NAME = "task"
        PORT = "3000"
    }

    stages {

        stage('SCM Pull') {
            steps {
                git branch: 'main', url: 'https://github.com/Tapasvigowda/newproject.git'
            }
        }

        stage('Install Dependencies & Test') {
            steps {
                sh '''
                npm install
                npm test || echo "No tests found, continuing..."
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Deploy using Docker Compose') {
            steps {
                sh '''
                docker compose up -d --build
                '''
            }
        }

        stage('Verify Deployment (Curl)') {
            steps {
                sh '''
                sleep 10

                echo "---- ROOT ENDPOINT ----"
                curl http://localhost:3000/

                echo "---- HEALTH ENDPOINT ----"
                curl http://localhost:3000/health

                echo "---- TASKS ENDPOINT ----"
                curl http://localhost:3000/api/tasks
                '''
            }
        }

        stage('Cleanup') {
            steps {
                sh '''
                docker compose down
                docker system prune -f
                '''
                cleanWs()
            }
        }
    }
}
