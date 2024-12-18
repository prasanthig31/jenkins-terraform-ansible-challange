pipeline {
    agent any
    environment {
        // Define any environment variables, such as paths or credentials
        ANSIBLE_HOME = '/usr/local/bin' // Path to Ansible binary (if it's custom)
        INVENTORY_FILE = '/var/lib/jenkins/workspace/ansible-tf/ansible-task/inventory.yml'
        PLAYBOOK_FILE = 'ssh-keygencopy.yml'
    }


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
                    dir('/var/lib/jenkins/workspace/') {
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
        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Run the Ansible playbook using the ansible-playbook command
                    sh """
                        ansible-playbook -i ${INVENTORY_FILE} ${PLAYBOOK_FILE}
                    """
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
