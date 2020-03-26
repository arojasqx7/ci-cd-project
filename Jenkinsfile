pipeline {
   agent any

   environment {
       ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID') 
       SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
       TF_HOME = tool('terraform-0.12.6')
   }  
   stages {
      stage('Terraform-Init') {
         steps {
             dir('terraform')
                 echo 'Hello World from terraform folder..'
         }
      }
   }
}