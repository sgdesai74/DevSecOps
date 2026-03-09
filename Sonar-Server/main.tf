provider "aws" {
  region = var.region
}

# Create Security Group
resource "aws_security_group" "sonar_sg" {
  name        = "sonar-sg"
  description = "Allow SSH and Sonar"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Sonar"
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

# EC2 Instance
resource "aws_instance" "sonar" {
  ami           = "ami-06e3c045d79fd65d9"
  instance_type = var.instance_type
  key_name      = "jenkins-ssh-keypair"

  vpc_security_group_ids = [aws_security_group.sonar_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "Sonar-Server"
  }
}
