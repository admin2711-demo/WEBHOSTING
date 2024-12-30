provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP access"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

# EC2 Instance 1
resource "aws_instance" "instance1" {
  ami           = "ami-064519b8c76274859"  # Updated AMI ID
  instance_type = "t2.micro"
  key_name      = "taskkey"  # Replace with your key pair name
  subnet_id     = "subnet-054d8e27b7a066345"  # Updated Subnet ID
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "Instance1"
  }

  associate_public_ip_address = true  # Ensures the instance has a public IP for internet access
}

# EC2 Instance 2
resource "aws_instance" "instance2" {
  ami           = "ami-064519b8c76274859"  # Updated AMI ID
  instance_type = "t2.micro"
  key_name      = "taskkey"  # Replace with your key pair name
  subnet_id     = "subnet-054d8e27b7a066345"  # Updated Subnet ID
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "Instance2"
  }

  associate_public_ip_address = true  # Ensures the instance has a public IP for internet access
}

output "instance1_public_ip" {
  value = aws_instance.instance1.public_ip
}

output "instance2_public_ip" {
  value = aws_instance.instance2.public_ip
}
