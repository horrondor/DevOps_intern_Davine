pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'docker compose build'
            }
        }

        stage('Test') {
            steps {
                sh '''
                    echo "Running application tests..."

                    if [ -f mern_shopnest/backend/package.json ]; then
                        cd mern_shopnest/backend
                        npm test -- --runInBand || true
                    fi
                '''
            }
        }

        stage('Validation') {
            steps {
                sh '''
                    echo "Validating Docker Compose configuration..."
                    docker compose config

                    echo "Validating Docker images..."
                    docker images | grep mern/
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    echo "Starting MERN application..."

                    docker compose down || true
                    docker compose up -d

                    echo "Running containers:"
                    docker compose ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the Console Output.'
        }

        always {
            sh 'docker compose ps || true'
        }
    }
}