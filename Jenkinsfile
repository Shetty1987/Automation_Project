pipeline{
    //agent any
    agent { label 'docker' }
    options {
        buildDiscarder(logRotator(numToKeepStr: '1'))
    }
    parameters { string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '') }
    triggers { cron('H */4 * * 1-5') 
    pollSCM('H */4 * * 1-5')
    }
    stages{
        stage('build')
        {
            steps{
                sh "echo hello"
            }
        }
        stage('deploy')
        {
            steps{
                sh "sleep 10"
            }
        }
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
    }
}