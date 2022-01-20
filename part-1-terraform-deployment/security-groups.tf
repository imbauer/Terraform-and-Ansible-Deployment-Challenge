# Create security group to allow http access on port 80 and incomming traffic on port 22 (so that ansible can connect)
resource "aws_security_group" "nginx" {
  name        = "nginx"
  description = "Allow inbound traffic on port 80"
  vpc_id      = aws_vpc.tadc_vpc.id
  depends_on  = [aws_vpc.tadc_vpc]

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}