provider "aws" {
  region = "ap-southeast-1"
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets from default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create security group
resource "aws_security_group" "my_first_instance_sg" {
  name        = "my_first_instance_sg"
  description = "Security group for my first EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  # Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_first_instance_sg"
  }
}

# Create EC2 instance
resource "aws_instance" "my_first_instance" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t2.micro"
  key_name                    = "cantrill"
  vpc_security_group_ids      = [aws_security_group.my_first_instance_sg.id]
  subnet_id                   = tolist(data.aws_subnets.default.ids)[0]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "my-first-instance"
  }
}

# Output public IP address and success message
output "instance_public_ip" {
  value = aws_instance.my_first_instance.public_ip
}

output "success_message" {
  value = "EC2 instance '${aws_instance.my_first_instance.tags.Name}' is now running!"
}
