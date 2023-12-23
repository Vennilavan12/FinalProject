pipeline {
    agent any
    environment {
    dockerImage=''
    registry="vennilavan/dev"
    }
    stages {
      stage ('Build') {
        steps {
          script {
            dockerImage = docker.build registry + ":$BUILD_NUMBER"
          }
        }
      }
    stage ('Push Image to Dockerhub') {
      steps {  
        script {
          docker login -u $DOCKER_USERNAME -p $DOCKER_PASS
          dockerImage.push("latest")
          }
        } 
      }
        
    stage('Deploy to Deployment server') {
      steps {
        script {
          sshagent(['ssh-mach']) {
          // Execute the command within the  sshagent block using sh step
              sh 'ssh -o StrictHostKeyChecking=no ubuntu@18.61.101.102 "docker pull vennilavan/dev; docker stop $(docker ps -a -q) ; docker run -d -p 80:4000 vennilavan/dev"'
          }
        }
      }
    }
  }  
}
 