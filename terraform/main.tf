provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "jenkins-slaves" {
  ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = "t2.small"
  key_name               = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id              = "${aws_subnet.public-subnet-1.id}"
  count                  = "2"  

  associate_public_ip_address = true
  tags = {
      Name = "${lookup(var.instance_names, count.index)}"
  }
}

resource "aws_vpc" "jenkins-ci-cd" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "Jenkins-VPC"
    }
}

resource "aws_subnet" "public-subnet-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.jenkins-ci-cd.id}"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Jenkins-Public-Subnet-1"
  }
}

resource "aws_internet_gateway" "jenkins-vpc-ig" {
  vpc_id = "${aws_vpc.jenkins-ci-cd.id}"

  tags = {
      Name = "Jenkins-vpc-internet-gateway"
  }
}

resource "aws_route_table" "jenkins-route-table" {
  vpc_id = "${aws_vpc.jenkins-ci-cd.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.jenkins-vpc-ig.id}"
  }

  tags = {
    Name = "Jenkins-Route-Table"
  }
}

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = "${aws_vpc.jenkins-ci-cd.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }   
}