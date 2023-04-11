provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0efa651876de2a5ce"
  instance_type = "t2.micro"
  user_data = file("jenkins-install.sh")
  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name = aws_key_pair.jenkins_ssh_key.key_name

  tags = {
    Name = "JenkinsServerInstance"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"

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

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_key_pair" "jenkins_ssh_key" {
  key_name   = "jenkins_ssh_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "local_private_key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "local_private_key"
}