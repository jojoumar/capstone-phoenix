resource "aws_security_group" "k3s_sg" {
  name        = "phoenix-k3s-sg"
  description = "Security group for K3s cluster"
  vpc_id      = aws_vpc.phoenix_vpc.id

    ingress {
    description = "SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Kubernetes API"

    from_port = 6443
    to_port   = 6443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Flannel VXLAN"

    from_port = 8472
    to_port   = 8472
    protocol  = "udp"

    self = true
  }

    ingress {
    description = "Kubelet"

    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"

    self = true
  }

    ingress {
    description = "NodePort"

    from_port = 30000
    to_port   = 32767
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phoenix-k3s-sg"
  }
}