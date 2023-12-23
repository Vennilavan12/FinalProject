# Define provider (AWS in this case)
provider "aws" {
  region = var.aws_region # Change this to your desired region
}

# Create security group for EC2 instance
resource "aws_security_group" "Final" {
  name        = "Final"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Create security group for EC2 instance
resource "aws_security_group" "Final1" {
  name        = "Final1"
  description = "Allow SSH, HTTP, Jenkins (8080), and MySQL (3306) traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9323
    to_port     = 9323
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}  
# Launch EC2 instance
resource "aws_instance" "BuildEC2" {
  ami             = "ami-05fb0b8c1424f266b" # Specify the desired AMI ID
  instance_type   = "t2.medium"
  key_name        = "linux"
  vpc_security_group_ids  = [aws_security_group.Final.id]
  tags = {
    Name        = "Build Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install openjdk-17-jre -y
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian/jenkins.io-2023.key
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update
              sudo apt-get install jenkins -y
              sudo apt install docker.io -y
              sudo chmod 777 /var/run/docker.sock
              EOF
}
resource "aws_instance" "DeployEC2" {
  ami             = "ami-05fb0b8c1424f266b" # Specify the desired AMI ID
  instance_type   = "t2.micro"
  key_name        = "linux"
  vpc_security_group_ids  = [aws_security_group.Final1.id]
  tags = {
    Name        = "Deployment Server"
  }
 user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install openjdk-17-jre -y
              sudo apt-get update
              sudo apt install docker.io -y
              sudo chmod 777 /var/run/docker.sock
              EOF
}  
# Create MySQL RDS instance
resource "aws_db_instance" "mysql_rds" {
  identifier           = var.db_instance_identifier
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  #name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.Final.id]
}
