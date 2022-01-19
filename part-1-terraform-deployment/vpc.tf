# Create vpc
resource "aws_vpc" "tadc_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform and Ansible Deployment Challenge"
  }

}

# Create public subnet
resource "aws_subnet" "tadc_public" {
  vpc_id = aws_vpc.tadc_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tadc-public-subnet-2a"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "tadc_internet_gateway" {
  vpc_id = aws_vpc.tadc_vpc.id
  tags = {
    Name = "tadc-internet_gateway"
  }
}

# Create route table and connect it to the internet gateway (without route table and internet gateway, url would not be reachable from the internet)
resource "aws_route_table" "tadc_route_table" {
  vpc_id = aws_vpc.tadc_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tadc_internet_gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.tadc_internet_gateway.id
  }

  tags = {
    Name = "tadc-public-route-table"
  }
}

# Connect route table and subnet
resource "aws_route_table_association" "tadc_route_table_association" {
  subnet_id = aws_subnet.tadc_public.id
  route_table_id = aws_route_table.tadc_route_table.id
}
