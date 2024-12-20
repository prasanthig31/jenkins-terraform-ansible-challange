pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws') // ID from Jenkins credentials store
        AWS_SECRET_ACCESS_KEY = credentials('aws') // ID from Jenkins credentials store
     }
    stages {
        

        
        
        stage('Terraform Apply') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/proxy/') {
                    sh 'pwd'
                    sh 'terraform init'
                    sh 'terraform validate'
                    // sh 'terraform destroy -auto-approve'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Ansible Deployment') {
            steps {
                script {
                   sleep '360'
                    ansiblePlaybook becomeUser: 'ec2-user', credentialsId: 'ec2-user', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/proxy/inventory.yml', playbook: '/var/lib/jenkins/workspace/proxy/frontend.yml', vaultTmpPath: ''
                    ansiblePlaybook becomeUser: 'ubuntu', credentialsId: 'ubuntu', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/proxy/inventory.yml', playbook: '/var/lib/jenkins/workspace/proxy/backend.yml', vaultTmpPath: ''
                }
            }
        }
        
      
    }
}
