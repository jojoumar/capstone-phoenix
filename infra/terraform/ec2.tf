## Find the latest Ubuntu 22.04 AMI

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## Create the Control Plane

resource "aws_instance" "control_plane" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids       = [aws_security_group.k3s_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "control-plane"
    Role = "server"
  }
}

## Create the First Worker Node

resource "aws_instance" "worker1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids       = [aws_security_group.k3s_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "worker-1"
    Role = "agent"
  }
}

### Create the Second Worker Node

resource "aws_instance" "worker2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids       = [aws_security_group.k3s_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "worker-2"
    Role = "agent"
  }
}