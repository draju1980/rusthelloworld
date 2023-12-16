provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "app_node" {
  ami                    = "ami-0694d931cee176e7d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_security_group.id]

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              apt-get update -y
              apt-get install -y docker.io
              sudo usermod -aG docker ec2-user
              # Pull and run your container image
              sudo docker pull ghcr.io/draju1980/esys_helloworld:sha256-6e95ab34af3e94c9b3ebcbf56c80211fe061cd4dd38ea9bd4e318b18fe3b95d7.sig
              sudo docker run -d -p 8080:8080 ghcr.io/draju1980/esys_helloworld:sha256-6e95ab34af3e94c9b3ebcbf56c80211fe061cd4dd38ea9bd4e318b18fe3b95d7.sig
              EOF

  tags = {
    Name = "app_node"
  }
}

resource "aws_security_group" "app_security_group" {
  name        = "app_security_group"
  description = "Security group for app instances"

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
