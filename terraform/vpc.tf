resource "aws_vpc" "vpro_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpro_vpc"
  }
}

resource "aws_subnet" "pub-sub-1" {
  vpc_id                  = aws_vpc.vpro_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-1"
  }
}

resource "aws_subnet" "pub-sub-2" {
  vpc_id                  = aws_vpc.vpro_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-2"
  }
}

resource "aws_subnet" "priv-sub-1" {
  vpc_id            = aws_vpc.vpro_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-1b"


  tags = {
    Name = "priv-sub-1"
  }
}

resource "aws_subnet" "priv-sub-2" {
  vpc_id            = aws_vpc.vpro_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-1c"


  tags = {
    Name = "priv-sub-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpro_vpc.id

  tags = {
    Name = "gw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpro_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "pub-sub-1-ass" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "pub-sub-2-ass" {
  subnet_id      = aws_subnet.pub-sub-2.id
  route_table_id = aws_route_table.rt.id
}








