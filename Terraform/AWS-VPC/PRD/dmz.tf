# Public DMZ subnet
resource "aws_subnet" "dmz-a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.dmz_cidr_a}"
  availability_zone = "us-west-2a"
  tags {
    Name = "${var.environment}-dmz-a"
  }
}

resource "aws_subnet" "dmz-b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.dmz_cidr_b}"
  availability_zone = "us-west-2b"
  tags {
    Name = "${var.environment}-dmz-b"
  }
}

resource "aws_subnet" "dmz-c" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.dmz_cidr_c}"
  availability_zone = "us-west-2c"
  tags {
    Name = "${var.environment}-dmz-c"
  }
}

## IGW Begin ##
# Define the internet gateway
resource "aws_internet_gateway" "gw1" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.environment}-IGW"
  }
}

# Define the route table
resource "aws_route_table" "public-dmz-igw" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw1.id}"
  }
  route {
    cidr_block = "${var.ol_vpn_pool}"
    gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
  }
  tags {
    Name = "${var.environment} DMZ Routes"
  }
}
## IGW End ##

# Route Table
# Assign the DMZ route table to public IP
resource "aws_route_table_association" "route-dmz-a" {
 subnet_id = "${aws_subnet.dmz-a.id}"
 route_table_id = "${aws_route_table.public-dmz-igw.id}"
}

resource "aws_route_table_association" "route-dmz-b" {
 subnet_id = "${aws_subnet.dmz-b.id}"
 route_table_id = "${aws_route_table.public-dmz-igw.id}"
}

resource "aws_route_table_association" "route-dmz-c" {
 subnet_id = "${aws_subnet.dmz-c.id}"
 route_table_id = "${aws_route_table.public-dmz-igw.id}"
}

# VPN Routing
resource "aws_vpn_gateway_route_propagation" "dmz-routing" {
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gw.id}"
  route_table_id = "${aws_route_table.public-dmz-igw.id}"
}
