pipeline {
  agent any
  
  
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-id')
     }
     

  stages {
    stage('Docker build') {
      steps {
        echo 'Running Docker Build command'
        sh 'docker build -t test-image-aditya .'
      }
    }

    stage('Docker Hub Image Push') {
      steps {
		echo 'Pushing Docker Image to hub'
		sh '''
		docker tag test-image-aditya devad14/test-image-aditya:latest
		echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
		docker push devad14/test-image-aditya:latest
		'''
      }
    }
  }
}
