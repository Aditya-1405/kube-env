pipeline {
  agent any

  stages {
    stage('Docker build') {
      steps {
        echo 'Running Docker Build command'
        sh ' docker build -t test-image-aditya .'
      }
    }

    stage('Docker Hub Image Push') {
      steps {
        echo 'Pushing Docker Image to hub'
        sh '''
		docker tag test-image-aditya devad14/test-image-aditya:latest
        docker login -u devad14 -p Dev14@adi
        docker push devad14/test-image-aditya:latest
		'''
      }
    }
  }
}
