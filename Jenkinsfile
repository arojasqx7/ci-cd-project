pipeline {
   agent any

   tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.6"
    }

   environment {
       ACCESS_KEY        = credentials('AWS_ACCESS_KEY_ID') 
       SECRET_KEY        = credentials('AWS_SECRET_ACCESS_KEY')
       SLAVES_KEYPAIR    = credentials('JENKINS_SLAVES_AWS_KEYPAIR')
   }  
   stages {
      stage('Terraform-Init') {
         steps {
             dir('terraform') {
                 sh 'terraform init'
             }
         }
      }
      stage('Terraform-Plan') {
         steps {
             dir('terraform') {
                 sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY'"
             }
         }
      }
      stage('Terraform-Apply') {
         steps {
             dir('terraform') {
                 sh "terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -input=false -auto-approve"
             }
         }
      }
      stage('Ansible-Provision') {
          steps {
              dir('ansible') {
                  sh "ansible -m ping jenkins-slaves -i hosts --private-key=$SLAVES_KEYPAIR -u ec2-user"
              }
          }
      }
   }
}