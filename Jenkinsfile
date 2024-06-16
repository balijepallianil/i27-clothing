// Jenkinsfile to build and deploy the apps to various environments 
// Jenkinsfile to deploy our react based applications
pipeline {
    agent any
        tools{
           jdk 'JDK-17'
        }
        environment {
            APPLICATION_NAME = "clothing"
            DOCKER_HUB = "docker.io/i27anilb3"
            DOCKER_CREDS = credentials('docker_creds')
            MAHA_CREDS = credentials('maha_creds')
        }
        stages {
            stage('imageBuild') {
                step {
                  sh "docker build --force-rm --no-cache -t ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT} ."
                }    
            }
            stage ('DockerPushToHub') {
                step {
                  sh "docker login -u ${DOCKER_CREDS_USR} -p ${DOCKER_CREDS_PSW}"
                  sh "docker push ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}"
                }           
            }
            stage ('Dev Deploy') {
                step {
                  sh "sshpass -p ${MAHA_CREDS_PSW} ssh -o StrictHostKeyChecking=no ${MAHA_CREDS_USR}@${DOCKER_DEPLOY_HOST_IP} docker run -P --name ${env.APPLICATION_NAME}-dev ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}"
                }
            }
        }
}