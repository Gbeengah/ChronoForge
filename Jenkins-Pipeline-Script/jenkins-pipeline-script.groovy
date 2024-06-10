pipeline script - pipeline {
    agent any
    tools {
    nodejs '20.12.2' 
}

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', // Replace 'main' with your branch name if needed
                credentialsId: 'gheebhal', // Replace with your actual ID
                url: 'https://github.com/Gbeengah/ChronoForge'
            }
        }

        stage('Install dependencies') {
            steps {
                // Install npm dependencies
                sh 'npm install'
            }
        }

        stage('docker build & push') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'badcae0b-cb4a-458c-84ff-fbf9b5f1a95c') {
                      sh "docker build -t gbeengah/gheebhee:tag979 ."
                      sh "docker push gbeengah/gheebhee:tag979"
                      }
                }
            }
        }
    }

    post {
        always {
            // Any cleanup steps or actions to be performed always
            echo 'Pipeline completed'
        }
    }
}
current pipeline script