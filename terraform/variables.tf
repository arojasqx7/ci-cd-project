variable "access_key" {

}
variable "secret_key" {
  
}
variable "region" {
  default = "us-east-1"
}
variable "keyname" {
  default = "jenkins-ci-cd-tutorial"
}
variable "instance_names"{
  default = {
    "0" = "Jenkins-Slave-1"
    "1" = "Jenkins-Slave-2"
  }
}
