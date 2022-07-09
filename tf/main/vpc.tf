resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/24"
  # First IP 10.0.0.0 - Last IP 10.0.0.255
  # an IPv4 consists of 32 bits, and the remaining bits you attach to the end of a CIDR (e.g., .../24) tells you how many addresses you get, so in this case you get 256 addresses (32 - 24 = 8, 2^8 = 256)
  instance_tenancy = "default"
  tags = {
    Name        = "main"
    Environment = "dev"
  }
}

# we want 4 subnets out of the VPC CIDR range, each subnet should have 64 addresses (256/4 = 64)
# so we reduce the remaining bits by 2 (to 26) to get 64 addresses in each subnet, (32 - 26 = 6, 2^6 = 64)
# upon creation we see only 59 addresses in the console actually, I think AWS reserves 5 addresses for reasons I don't know
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "${var.region}a"
  # First IP 10.0.0.0 - Last IP 10.0.0.63
  tags = {
    Name        = "public-a"
    Environment = "dev"
  }
}
# ^ being used with prototype-a

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.64/26"
  availability_zone = "${var.region}b"
  # First IP 10.0.0.64 - Last IP 10.0.0.127
  tags = {
    Name        = "public-b"
    Environment = "dev"
  }
}
# ^ being used with prototype-b

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.128/26"
  availability_zone = "${var.region}c"
  # First IP 10.0.0.128 - Last IP 10.0.0.191
  tags = {
    Name        = "private-c"
    Environment = "dev"
  }
}
# ^ being used with prototype-b

# For private subnets, we need to attach a NAT gateway to connect to the outside world
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.private_c.id
  depends_on    = [aws_internet_gateway.main]
  tags = {
    Name        = "for subnet ${aws_subnet.private_c.id}"
    Environment = "dev"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = {
    Name        = "for NAT gateway ${aws_nat_gateway.main.id}"
    Environment = "dev"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.subnet_private_c.id
  }
}

resource "aws_route_table_association" "subnet_private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "private_d" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.192/26"
  availability_zone = "${var.region}d"
  # First IP 10.0.0.192 - Last IP 10.0.0.255
  tags = {
    Name        = "private-d"
    Environment = "dev"
  }
}

# how I figured out subnets CIDRs based on vpc CIDR - https://medium.com/geekculture/aws-vpc-and-subnet-cidr-calculation-and-allocation-cfbe69050712
# https://www.ipaddressguide.com/cidr

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "subnet_public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_route_table.id
}
# figured out (IG, RT and RTAs) for subnets public_a and public_b subnets ^ and some other ECSy things from here - https://github.com/datamindedbe/webinar-containers/tree/2b2f976f8098ade2c8e5c75b413af33ebcbf7b14/PART%20III/infrastructure
# ^ configured subnet public_a for ECS task hello-world (prototype-a) to be able to pull images from ECR - https://aws.amazon.com/premiumsupport/knowledge-center/ecs-pull-container-error/
