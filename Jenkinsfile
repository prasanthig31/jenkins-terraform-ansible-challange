pipeline {
    agent any

    stages {
        

        stage('Checkout') {
            steps {
                deleteDir()
                sh 'echo cloning repo'
                sh 'git clone https://github.com/prasanthig31/jenkins-terraform-ansible-challange.git' 
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/ansible-tf/ansible-task/') {
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
                    ansiblePlaybook becomeUser: 'ec2-user', credentialsId: 'amazonlinux', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/frontend.yml', vaultTmpPath: ''
                    ansiblePlaybook become: true, credentialsId: 'ubuntuuser', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/backend.yml', vaultTmpPath: ''
                }
            }
        }
    }
}
