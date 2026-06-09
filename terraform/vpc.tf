resource "aws_vpc" "url-shortener_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "url-shortener-tf-vpc"
  }
}

resource "aws_subnet" "url-shortener_public1" {
  vpc_id                  = aws_vpc.url-shortener_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "url-shortener-public-1"
  }
}
resource "aws_subnet" "url-shortener_private1" {
  vpc_id            = aws_vpc.url-shortener_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = "url-shortener-private-1"
  }
}
resource "aws_subnet" "url-shortener_private2" {
  vpc_id            = aws_vpc.url-shortener_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "eu-north-1c"

  tags = {
    Name = "url-shortener-private-2"
  }
}

resource "aws_internet_gateway" "url-shortener_igw" {
  vpc_id = aws_vpc.url-shortener_vpc.id

  tags = {
    Name = "url-shortener-igw"
  }
}

resource "aws_route_table" "url-shortener_public_rt" {
  vpc_id = aws_vpc.url-shortener_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.url-shortener_igw.id
  }

  tags = {
    Name = "url-shortener-public-rt"
  }
}

resource "aws_route_table_association" "url-shortener_public_assoc" {
  subnet_id      = aws_subnet.url-shortener_public1.id
  route_table_id = aws_route_table.url-shortener_public_rt.id
}      