resource "aws_vpc" "my-vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = var.vpc-name
    }  
}

resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
    Name = var.igw-name
}
}
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.cidr_public
    availability_zone = var.public-subnet-zone
    tags = {
      Name = var.public-subnet
    }
  
}
resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.cidr_private
    availability_zone = var.private-subnet-zone
    tags = {
      Name = var.private-subnet
    }
  
}
resource "aws_route_table" "rt-public" {
    vpc_id = aws_vpc.my-vpc.id
tags = {
      Name = var.rt-public
    }
}
resource "aws_route_table" "rt-private" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = var.rt-private
}
}
resource "aws_route" "rt" {
    route_table_id = aws_route_table.rt-public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id

}
resource "aws_route_table_association" "public-A" {
      route_table_id = aws_route_table.rt-public.id
      subnet_id = aws_subnet.public-subnet.id 
}

resource "aws_route_table_association" "private-A" {
      route_table_id = aws_route_table.rt-private.id
      subnet_id = aws_subnet.private-subnet.id 
}