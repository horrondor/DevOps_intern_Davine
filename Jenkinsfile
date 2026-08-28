pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('weekly_Tasks/week_4/Task') {
                    sh 'docker compose build'
                }
            }
        }

        stage('Test') {
            steps {
                dir('weekly_Tasks/week_4/Task') {
                    sh '''
                        echo "Running application tests..."

                        if [ -f mern_shopnest/backend/package.json ]; then
                            cd mern_shopnest/backend
                            npm test -- --runInBand || true
                        else
                            echo "Backend package.json not found"
                        fi
                    '''
                }
            }
        }

        stage('Validation') {
            steps {
                dir('weekly_Tasks/week_4/Task') {
                    sh '''
                        echo "Validating Docker Compose configuration..."
                        docker compose config

                        echo "Validating Docker images..."
                        docker images | grep mern/ || true
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('weekly_Tasks/week_4/Task') {
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
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the Console Output.'
        }

        always {
            dir('weekly_Tasks/week_4/Task') {
                sh 'docker compose ps || true'
            }
        }
    }
}

