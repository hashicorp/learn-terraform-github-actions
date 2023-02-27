terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.50"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

 cloud {
    organization = "QATIP2697"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

#resource "aws_vpc" "lab_vpc" {
resource "aws_vpc" "lab-vpc" {
    cidr_block = "10.1.0.0/16"
}

resource "aws_internet_gateway" "labigw" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name = "lab-ig"
  }
}

resource "aws_subnet" "public-subnet" {
    vpc_id     = aws_vpc.lab-vpc.id
    cidr_block = "10.1.10.0/24"

    tags = {
    Name = "public-subnet"
    }
    
}

data "aws_availability_zones" "azlist" {
  state = "available"
}
    
resource "aws_subnet" "private-subnets" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.lab-vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.azlist.names[count.index]
  vpc_id            = aws_vpc.lab-vpc.id

  tags = {
    Name = "private-subnet"
  }


}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.lab-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id=aws_internet_gateway.labigw.id
  }
  tags = {
  Name = "public-route"
  }


}

resource "aws_eip" "static_ip" {
  vpc      = true
}

resource "aws_nat_gateway" "labnatgw" {
  allocation_id = aws_eip.static_ip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "lab_nat_gw"
  }

  # Ensuring IGW is created
  # Ensuring EIP is created
  depends_on = [aws_internet_gateway.labigw, aws_eip.static_ip]
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.lab-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id=aws_nat_gateway.labnatgw.id
  }
  tags = {
  Name = "private-route"
  }
}
  
resource "aws_route_table_association" "public_rta" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta" {
  count = var.az_count
  subnet_id      = "${element(aws_subnet.private-subnets.*.id, count.index)}"
    route_table_id = aws_route_table.private_rt.id
}


