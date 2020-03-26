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
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}
