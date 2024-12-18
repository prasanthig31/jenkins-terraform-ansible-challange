pipeline {
    agent any
    environment {
        // Define any environment variables, such as paths or credentials
        AWS_ACCESS_KEY_ID = credentials('aws') // ID from Jenkins credentials store
        AWS_SECRET_ACCESS_KEY = credentials('aws') // ID from Jenkins credentials store
        ANSIBLE_HOME = '/usr/local/bin' // Path to Ansible binary (if it's custom)
        INVENTORY_FILE = '/var/lib/jenkins/workspace/proxy/inventory.yml'
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
                    dir('/var/lib/jenkins/workspace/proxy') {
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
       
    }
}
