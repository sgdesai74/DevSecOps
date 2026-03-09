provider "aws" {
  region = var.region
}

# Create Security Group
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
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

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-ssh-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

# EC2 Instance
resource "aws_instance" "jenkins" {
  ami           = "ami-06e3c045d79fd65d9"
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}
