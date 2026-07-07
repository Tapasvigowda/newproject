pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Tapasvigowda/newproject.git'
            }
        }

        stage('Install & Test') {
            steps {
                sh '''
                npm install
                npm test
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t task:t1 .
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f task-tracker || true
                docker run -d -p 3000:3000 --name task:t1 task:t1
                '''
            }
        }

        stage('Check App') {
            steps {
                sh '''
                sleep 5
                curl http://localhost:3000/health
                '''
            }
        }
    }
}
