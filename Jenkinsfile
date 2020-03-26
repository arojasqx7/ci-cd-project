pipeline {
   agent any

   tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.6"
    }

   environment {
       ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID') 
       SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
       TF_HOME = tool('terraform-0.12.6')
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
                 sh(""" terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' 
                        -out terraform.tfplan
                 """)
                 stash name: "terraform-plan", includes: "terraform.tfplan"
             }
         }
      }
      stage('Terraform-Apply') {
         steps {
             dir('terraform') {
                 unstash "terraform-plan"
                 sh "terraform apply terraform.tfplan -input=false -auto-approve"
             }
         }
      }
   }
}