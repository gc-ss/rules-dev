

#---- 0 ----

provider "aws" {
  alias  = "local"
  region = "us-east-1"
}

provider "aws" {
  alias  = "peer"
  region = "us-west-2"
}

data "aws_region" "peer" {
  provider = aws.peer
}

resource "aws_ec2_transit_gateway" "local" {
  provider = aws.local

  tags = {
    Name = "Local TGW"
  }
}

resource "aws_ec2_transit_gateway" "peer" {
  provider = aws.peer

  tags = {
    Name = "Peer TGW"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment" "example" {
  peer_account_id         = aws_ec2_transit_gateway.peer.owner_id
  peer_region             = data.aws_region.peer.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.peer.id
  transit_gateway_id      = aws_ec2_transit_gateway.local.id

  tags = {
    Name = "TGW Peering Requestor"
  }
}