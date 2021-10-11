resource "aws_vpc" "anz_vpc" {
  cidr_block = var.cidr_block
  tags       = var.tags
}

resource "aws_internet_gateway" "anz_igw" {
  vpc_id = aws_vpc.anz_vpc.id
  tags   = var.tags
}

resource "aws_subnet" "anz_public" {
  vpc_id            = aws_vpc.anz_vpc.id
  cidr_block        = var.pub_cidr_block
  availability_zone = var.pub_subnet_az

  tags = var.tags
}

resource "aws_subnet" "anz_private" {
  vpc_id            = aws_vpc.anz_vpc.id
  cidr_block        = var.pri_cidr_block
  availability_zone = var.pri_subnet_az

  tags = var.tags
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.anz_vpc.id
  tags   = var.tags

}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.anz_igw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.anz_public.id
  route_table_id = aws_route_table.public.id
}



resource "aws_nat_gateway" "ngw" {
  subnet_id  = aws_subnet.anz_public.id
  connectivity_type = "private"
  tags       = var.tags
  depends_on = [aws_internet_gateway.anz_igw]
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.anz_vpc.id
  tags   = var.tags
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.anz_private.id
  route_table_id = aws_route_table.private.id

}
