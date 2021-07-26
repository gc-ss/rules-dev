

#---- 0 ----

provider "aws" {
  alias = "requester"

  # Requester's credentials.
}

provider "aws" {
  alias = "accepter"

  # Accepter's credentials.
}

resource "aws_vpc" "main" {
  provider = "aws.requester"

  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_vpc" "peer" {
  provider = "aws.accepter"

  cidr_block = "10.1.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true
}

data "aws_caller_identity" "peer" {
  provider = "aws.accepter"
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  provider = "aws.requester"

  vpc_id        = "${aws_vpc.main.id}"
  peer_vpc_id   = "${aws_vpc.peer.id}"
  peer_owner_id = "${data.aws_caller_identity.peer.account_id}"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = "aws.accepter"

  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

resource "aws_vpc_peering_connection_options" "requester" {
  provider = "aws.requester"

  # As options can't be set until the connection has been accepted
  # create an explicit dependency on the accepter.
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = "aws.accepter"

  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

#---- 1 ----

provider "aws" {
  region = "us-east-1"

  # Requester's credentials.
}

provider "aws" {
  alias  = "peer"
  region = "us-west-2"

  # Accepter's credentials.
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "peer" {
  provider   = "aws.peer"
  cidr_block = "10.1.0.0/16"
}

data "aws_caller_identity" "peer" {
  provider = "aws.peer"
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${aws_vpc.main.id}"
  peer_vpc_id   = "${aws_vpc.peer.id}"
  peer_owner_id = "${data.aws_caller_identity.peer.account_id}"
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

#---- 2 ----

resource "aws_vpc_peering_connection_accepter" "example" {
  # ... other configuration ...

  # There is no AWS EC2 API for reading auto_accept
  lifecycle {
    ignore_changes = ["auto_accept"]
  }
}