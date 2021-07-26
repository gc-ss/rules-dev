

#---- 0 ----

resource "aws_waf_regex_pattern_set" "example" {
  name                  = "tf_waf_regex_pattern_set"
  regex_pattern_strings = ["one", "two"]
}

#---- 1 ----

resource "aws_waf_regex_match_set" "example" {
  name = "example"

  regex_match_tuple {
    field_to_match {
      data = "User-Agent"
      type = "HEADER"
    }

    regex_pattern_set_id = "${aws_waf_regex_pattern_set.example.id}"
    text_transformation  = "NONE"
  }
}

resource "aws_waf_regex_pattern_set" "example" {
  name                  = "example"
  regex_pattern_strings = ["one", "two"]
}