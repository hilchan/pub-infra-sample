### Define the public subnet ###
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr_a}"
  availability_zone = "us-west-2a"

  tags {
    Name = "${var.environment}-public-sub-a"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr_b}"
  availability_zone = "us-west-2b"

  tags {
    Name = "${var.environment}-public-sub-b"
  }
}

resource "aws_subnet" "public-subnet-c" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr_c}"
  availability_zone = "us-west-2c"

  tags {
    Name = "${var.environment}-public-sub-c"
  }
}

###  Added NAT Gateway  ###
# resource "aws_eip" "nat1" {
#   vpc       = true
# }

resource "aws_eip" "nat2" {
  vpc       = true
}

resource "aws_eip" "nat3" {
  vpc       = true
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = "${aws_eip.nat2.id}"
  subnet_id = "${aws_subnet.dmz-b.id}"
  tags {
    Name = "GW NAT2"
    }
}

resource "aws_nat_gateway" "nat3" {
  allocation_id = "${aws_eip.nat3.id}"
  subnet_id = "${aws_subnet.dmz-c.id}"
  tags {
    Name = "GW NAT3"
    }
}

resource "aws_route_table" "public-routes" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat2.id}"
  }
  route {
    cidr_block = "${var.ol_vpn_pool}"
    gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
  }
  tags {
    Name = "${var.environment} Public Routes"
  }
}

# Assign the route table to the public Subnet with public IP
resource "aws_route_table_association" "public-routes-a" {
  subnet_id = "${aws_subnet.public-subnet-a.id}"
  route_table_id = "${aws_route_table.public-routes.id}"
}

resource "aws_route_table_association" "public-routes-b" {
  subnet_id = "${aws_subnet.public-subnet-b.id}"
  route_table_id = "${aws_route_table.public-routes.id}"
}

resource "aws_route_table_association" "public-routes-c" {
  subnet_id = "${aws_subnet.public-subnet-c.id}"
  route_table_id = "${aws_route_table.public-routes.id}"
}

# VPN Routing
resource "aws_vpn_gateway_route_propagation" "public-routing" {
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
  route_table_id = "${aws_route_table.public-routes.id}"
}
