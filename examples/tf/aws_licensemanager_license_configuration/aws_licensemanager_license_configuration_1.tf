data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}

resource "aws_instance" "example" {
  ami           = "${data.aws_ami.example.id}"
  instance_type = "t2.micro"
}

resource "aws_licensemanager_license_configuration" "example" {
  name                  = "Example"
  license_counting_type = "Instance"
}

resource "aws_licensemanager_association" "example" {
  license_configuration_arn = "${aws_licensemanager_license_configuration.example.arn}"
  resource_arn              = "${aws_instance.example.arn}"
}