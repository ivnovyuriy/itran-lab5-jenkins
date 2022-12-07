pipeline {
    agent any
    // Set up environment details
    environment {
        BRANCH_NAME = "staging"
        DOCKER_IMAGE = "ivanovyuriy/flask-hello"
    }
    
    options { 
        buildDiscarder(logRotator(numToKeepStr: '5')) 
    }
    // Parameters of the external machine, where we'll deploy out artifact
    parameters {
        string(name: "DEPLOY_USER", defaultValue: "ubuntu", trim: true, description: "Username on the deployment server")
        string(name: "DEPLOY_HOST", defaultValue: "ec2-174-129-162-119.compute-1.amazonaws.com", trim: true, description: "Address of the deployment server")
    }
    
    stages {
        // Stage 1 - Cloning Git
        stage("Cloning Git") {
            steps {
                echo "Checkout to ${BRANCH_NAME}"
                git([url: "https://github.com/ivnovyuriy/itran-lab5-jenkins.git", branch: env.BRANCH_NAME])
 
            }
        }
        // Stage 2 - Build our app via Docker
        stage("Build") {
            steps {
                script {
                    echo "Build stage"
                    app = docker.build(env.DOCKER_IMAGE)
                }
            }
        }
        // Stage 3 - Push out Docker image to Docker hub
        stage("Backup") {
            steps {
                script {
                    echo "Backup stage"
                    docker.withRegistry( "", "docker-hub")  {
                    app.push("$BUILD_NUMBER-$BRANCH_NAME")
                    app.push("latest")
          }
        }
      }
    }
        // Stage 4 - Deploy our app to external machine
        stage ("Deploy") {
            steps {
                echo "Deploy stage"
                sshagent(credentials : ["AWS_Creds"]) {
                    sh '''
                        [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                        ssh-keyscan -t rsa,dsa ${DEPLOY_HOST} >> ~/.ssh/known_hosts
                        scp deploy.sh ${DEPLOY_USER}@${DEPLOY_HOST}:~/
                        ssh ${DEPLOY_USER}@${DEPLOY_HOST} 
                        sudo chmod +x deploy.sh
                        ./deploy.sh
                        '''
                }
        }
    }
    }
    
    post {
        success {
            echo "Remove unused local Docker image"
            sh "docker rmi $DOCKER_IMAGE:$BUILD_NUMBER-$BRANCH_NAME"
        }
    }
} 
