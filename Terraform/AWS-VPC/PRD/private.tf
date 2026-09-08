### Define Private Subnet ###
resource "aws_subnet" "private-subnet-a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnet_cidr_a}"
  availability_zone = "us-west-2a"

  tags {
    Name = "${var.environment}-private-sub-a"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnet_cidr_b}"
  availability_zone = "us-west-2b"

  tags {
    Name = "${var.environment}-private-sub-b"
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnet_cidr_c}"
  availability_zone = "us-west-2c"

  tags {
    Name = "${var.environment}-private-sub-c"
  }
}

# Route Table
resource "aws_route_table" "private-routes" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
    }
  route {
    cidr_block = "${var.ol_vpn_pool}"
    gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
    }
  tags {
    Name = "${var.environment} Private Routes"
  }
}

resource "aws_route_table_association" "private-routes-a" {
  subnet_id = "${aws_subnet.private-subnet-a.id}"
  route_table_id = "${aws_route_table.private-routes.id}"
}

resource "aws_route_table_association" "private-routes-b" {
  subnet_id = "${aws_subnet.private-subnet-b.id}"
  route_table_id = "${aws_route_table.private-routes.id}"
}

resource "aws_route_table_association" "private-routes-c" {
  subnet_id = "${aws_subnet.private-subnet-c.id}"
  route_table_id = "${aws_route_table.private-routes.id}"
}

# VPN Routing
resource "aws_vpn_gateway_route_propagation" "private-routing" {
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
  route_table_id = "${aws_route_table.private-routes.id}"
}
