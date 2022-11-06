# vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# public subnet1
resource "aws_subnet" "pubsn1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pubsn1_cidr
  availability_zone = var.az1

  tags = {
    Name = var.pubsn1
  }
}

# public subnet2
resource "aws_subnet" "pubsn2" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.pubsn2_cidr
  availability_zone = var.az2

  tags = {
    Name = var.pubsn2
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

# public subnet route table
resource "aws_route_table" "pubsnrt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all
    gateway_id = aws_internet_gateway.igw.id
    
  }
  tags = {
    Name = var.pubsnrt
  }
}

# public subnet1 route table association
resource "aws_route_table_association" "pubrtass1" {
  subnet_id      = aws_subnet.pubsn1.id
  route_table_id = aws_route_table.pubsnrt.id
}

# public subnet2 route table association 
resource "aws_route_table_association" "pubrtass2" {
  subnet_id      = aws_subnet.pubsn2.id
  route_table_id = aws_route_table.pubsnrt.id
}

# private subnet1
resource "aws_subnet" "prvsn1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.prvsn1_cidr
  availability_zone = var.az1

  tags = {
    Name = var.prvsn1
  }
}

# private subnet2
resource "aws_subnet" "prvsn2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.orvsn2_cidr
  availability_zone = var.az2

  tags = {
    Name = var.prvsn2
  }
}

# elastic ip
resource "aws_eip" "eip" {
  vpc = true
}

# nat gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsn1.id

  tags = {
    Name = var.ngw_name
  }
}

# private route table
resource "aws_route_table" "prvsnrt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = var.all
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  
  tags = {
    Name = var.prvsnrt
  }
}

# private subnet1 route table association  
resource "aws_route_table_association" "prvrtass1" {
  subnet_id      = aws_subnet.prvsn1.id
  route_table_id = aws_route_table.prvsnrt.id
}

# private subnet2 route table association 
resource "aws_route_table_association" "prvrtass2" {
  subnet_id      = aws_subnet.prvsn2.id
  route_table_id = aws_route_table.prvsnrt.id
}