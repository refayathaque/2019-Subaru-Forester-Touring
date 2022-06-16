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
resource "aws_subnet" "main_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/26"
  # First IP 10.0.0.0 - Last IP 10.0.0.63
  tags = {
    Name        = "main-a"
    Environment = "dev"
  }
}

resource "aws_subnet" "main_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.64/26"
  # First IP 10.0.0.64 - Last IP 10.0.0.127
  tags = {
    Name        = "main-b"
    Environment = "dev"
  }
}

resource "aws_subnet" "main_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.128/26"
  # First IP 10.0.0.128 - Last IP 10.0.0.191
  tags = {
    Name        = "main-c"
    Environment = "dev"
  }
}

resource "aws_subnet" "main_d" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.192/26"
  # First IP 10.0.0.192 - Last IP 10.0.0.255
  tags = {
    Name        = "main-d"
    Environment = "dev"
  }
}

# how I figured out subnets CIDRs based on vpc CIDR - https://medium.com/geekculture/aws-vpc-and-subnet-cidr-calculation-and-allocation-cfbe69050712
# https://www.ipaddressguide.com/cidr
