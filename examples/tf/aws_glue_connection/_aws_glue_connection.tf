

#---- 0 ----

resource "aws_glue_connection" "example" {
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://example.com/exampledatabase"
    PASSWORD            = "examplepassword"
    USERNAME            = "exampleusername"
  }

  name = "example"
}

#---- 1 ----

resource "aws_glue_connection" "example" {
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_rds_cluster.example.endpoint}/exampledatabase"
    PASSWORD            = "examplepassword"
    USERNAME            = "exampleusername"
  }

  name = "example"

  physical_connection_requirements {
    availability_zone      = "${aws_subnet.example.availability_zone}"
    security_group_id_list = ["${aws_security_group.example.id}"]
    subnet_id              = "${aws_subnet.example.id}"
  }
}