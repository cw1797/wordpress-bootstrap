# Create a VPC
resource "aws_vpc" "otraw_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet within the VPC
resource "aws_subnet" "otraw_subnet" {
  vpc_id     = aws_vpc.otraw_vpc.id
  cidr_block = "10.0.1.0/24"
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "otraw_igw" {
  vpc_id = aws_vpc.otraw_vpc.id
}

# Create a route table for the VPC
resource "aws_route_table" "otraw_route_table" {
  vpc_id = aws_vpc.otraw_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.otraw_igw.id
  }
}

# Associate the subnet with the route table
resource "aws_route_table_association" "otraw_route_table_association" {
  subnet_id      = aws_subnet.otraw_subnet.id
  route_table_id = aws_route_table.otraw_route_table.id
}

##NOT YET REQUIRED - SITE NOT LIVE
# # Create an Elastic IP
# resource "aws_eip" "otraw_eip" {}

# Create a security group for the EC2 instance
resource "aws_security_group" "otraw_security_group" {
  name_prefix = "otraw_security_group"
  vpc_id = aws_vpc.otraw_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { #Docker port for tls secure connections
    from_port   = 2376
    to_port     = 2376
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
#   ingress {
#   from_port = 443
#   to_port = 443
#   protocol = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
}

# Create a network interface for the instance
# resource "aws_network_interface" "otraw_eni" {
#   subnet_id       = aws_subnet.otraw_subnet.id
#   security_groups = [aws_security_group.otraw_security_group.id]

  # Associate the Elastic IP with the network interface
  # associate_public_ip_address = true
  # NOT YET REQUIRED - SITE NOT LIVE
  # depends_on                  = [aws_eip.otraw_eip]

  # Use the EIP as the primary IP address of the interface
  # attachment {
  #   instance = aws_instance.otraw_instance.id
  #   device_index = 0
    # NOT YET REQUIRED - SITE NOT LIVE
    # public_ip = aws_eip.otraw_eip.public_ip
  # }
# }

# Launch an EC2 instance within the subnet
resource "aws_instance" "otraw_instance" {
  ami                         = "ami-065793e81b1869261"
  instance_type               = "t3.micro"
  key_name                    = "otraw-keys"
  subnet_id                   = aws_subnet.otraw_subnet.id
  vpc_security_group_ids      = [aws_security_group.otraw_security_group.id]
  associate_public_ip_address = true

  # Associate the Elastic IP with the instance
  # network_interface {
  #   network_interface_id = aws_network_interface.otraw_eni.id
  #   device_index         = 0
  # }
}

