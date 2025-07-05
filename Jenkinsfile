pipeline {
  agent any

  environment {
    // This is your Docker Hub username/password credential in Jenkins
    DOCKERHUB_CREDENTIALS = credentials('docker-id')
  }

  stages {
    stage('Docker build') {
      steps {
        echo 'Building Docker image...'
        sh 'docker build -t test-image-aditya .'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        echo 'Pushing image to Docker Hub...'
        sh '''
          docker tag test-image-aditya devad14/test-image-aditya:latest
          echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
          docker push devad14/test-image-aditya:latest
        '''
      }
    }

    stage('Deploy on EC2') {
      steps {
        echo 'Deploying to EC2...'
        // This ID must match your SSH Username + Private Key credential in Jenkins
        sshagent(['ec2-ssh']) {
          sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@13.127.108.196 '
              sudo systemctl start docker || sudo service docker start || true &&
              docker pull devad14/test-image-aditya:latest &&
              docker stop test-container || true &&
              docker rm test-container || true &&
              docker run -d --name test-container -p 8080:80 devad14/test-image-aditya:latest
            '
          '''
        }
      }
    }
  }

  post {
    always {
      echo 'Pipeline finished.'
    }
  }
}
