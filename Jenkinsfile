pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-id')  // Replace with your actual Docker Hub credentials ID
  }

  stages {
    stage('Docker build') {
      steps {
        echo 'Building Docker Image'
        sh 'docker build -t test-image-aditya .'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        echo 'Pushing to Docker Hub'
        sh '''
          docker tag test-image-aditya devad14/test-image-aditya:latest
          echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
          docker push devad14/test-image-aditya:latest
        '''
      }
    }

    stage('Deploy on EC2') {
      steps {
        echo 'Deploying on EC2'
        sshagent(['ec2-ssh']) {  // Replace 'ubuntu' with your actual SSH key credentials ID
          sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@43.204.231.116 '
              sudo systemctl start docker || sudo service docker start  &&
              docker pull devad14/test-image-aditya:latest &&
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
