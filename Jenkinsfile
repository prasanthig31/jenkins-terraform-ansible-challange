pipeline {
    agent any
    environment {
        // Define any environment variables, such as paths or credentials
    
        ANSIBLE_HOME = '/usr/local/bin' // Path to Ansible binary (if it's custom)
        INVENTORY_FILE = '/var/lib/jenkins/workspace/proxy/inventory.yml'
        PLAYBOOK_FILE = 'ssh-keygencopy.yml'
    }


    stages {
        
        stage('Terraform Apply') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/proxy') {
                    withAWS(credentials: 'aws')
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
        
       
    }
}
