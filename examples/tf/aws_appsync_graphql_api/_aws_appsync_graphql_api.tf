

#---- 0 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"
}

#---- 1 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = "example"

  user_pool_config {
    aws_region     = "${data.aws_region.current.name}"
    default_action = "DENY"
    user_pool_id   = "${aws_cognito_user_pool.example.id}"
  }
}

#---- 2 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "AWS_IAM"
  name                = "example"
}

#---- 3 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "AWS_IAM"
  name                = "example"

  schema = <<EOF
schema {
	query: Query
}
type Query {
  test: Int
}
EOF
}

#---- 4 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "OPENID_CONNECT"
  name                = "example"

  openid_connect_config {
    issuer = "https://example.com"
  }
}

#---- 5 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"

  additional_authentication_provider {
    authentication_type = "AWS_IAM"
  }
}

#---- 6 ----

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "appsync.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_appsync_graphql_api" "example" {
  # ... other configuration ...

  log_config {
    cloudwatch_logs_role_arn = "${aws_iam_role.example.arn}"
    field_log_level          = "ERROR"
  }
}

#---- 7 ----

resource "aws_dynamodb_table" "example" {
  name           = "example"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = "${aws_iam_role.example.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_dynamodb_table.example.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "tf_appsync_example"
}

resource "aws_appsync_datasource" "example" {
  api_id           = "${aws_appsync_graphql_api.example.id}"
  name             = "tf_appsync_example"
  service_role_arn = "${aws_iam_role.example.arn}"
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = "${aws_dynamodb_table.example.name}"
  }
}

#---- 8 ----

resource "aws_appsync_graphql_api" "test" {
  authentication_type = "API_KEY"
  name                = "tf-example"
  schema              = <<EOF
type Mutation {
    putPost(id: ID!, title: String!): Post
}

type Post {
    id: ID!
    title: String!
}

type Query {
    singlePost(id: ID!): Post
}

schema {
    query: Query
    mutation: Mutation
}
EOF
}

resource "aws_appsync_datasource" "test" {
  api_id = "${aws_appsync_graphql_api.test.id}"
  name   = "tf-example"
  type   = "HTTP"

  http_config {
    endpoint = "http://example.com"
  }
}

resource "aws_appsync_function" "test" {
  api_id                    = "${aws_appsync_graphql_api.test.id}"
  data_source               = "${aws_appsync_datasource.test.name}"
  name                      = "tf_example"
  request_mapping_template  = <<EOF
{
    "version": "2018-05-29",
    "method": "GET",
    "resourcePath": "/",
    "params":{
        "headers": $utils.http.copyheaders($ctx.request.headers)
    }
}
EOF
  response_mapping_template = <<EOF
#if($ctx.result.statusCode == 200)
    $ctx.result.body
#else
    $utils.appendError($ctx.result.body, $ctx.result.statusCode)
#end
EOF
}


#---- 9 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"
}

resource "aws_appsync_api_key" "example" {
  api_id  = "${aws_appsync_graphql_api.example.id}"
  expires = "2018-05-03T04:00:00Z"
}

#---- 10 ----

resource "aws_appsync_graphql_api" "test" {
  authentication_type = "API_KEY"
  name                = "tf-example"

  schema = <<EOF
type Mutation {
	putPost(id: ID!, title: String!): Post
}

type Post {
	id: ID!
	title: String!
}

type Query {
	singlePost(id: ID!): Post
}

schema {
	query: Query
	mutation: Mutation
}
EOF
}

resource "aws_appsync_datasource" "test" {
  api_id = "${aws_appsync_graphql_api.test.id}"
  name   = "tf_example"
  type   = "HTTP"

  http_config {
    endpoint = "http://example.com"
  }
}

# UNIT type resolver (default)
resource "aws_appsync_resolver" "test" {
  api_id      = "${aws_appsync_graphql_api.test.id}"
  field       = "singlePost"
  type        = "Query"
  data_source = "${aws_appsync_datasource.test.name}"

  request_template = <<EOF
{
    "version": "2018-05-29",
    "method": "GET",
    "resourcePath": "/",
    "params":{
        "headers": $utils.http.copyheaders($ctx.request.headers)
    }
}
EOF

  response_template = <<EOF
#if($ctx.result.statusCode == 200)
    $ctx.result.body
#else
    $utils.appendError($ctx.result.body, $ctx.result.statusCode)
#end
EOF

  caching_config {
    caching_keys = [
      "$context.identity.sub",
      "$context.arguments.id"
    ]
    ttl = 60
  }
}

# PIPELINE type resolver
resource "aws_appsync_resolver" "Mutation_pipelineTest" {
  type              = "Mutation"
  api_id            = "${aws_appsync_graphql_api.test.id}"
  field             = "pipelineTest"
  request_template  = "{}"
  response_template = "$util.toJson($ctx.result)"
  kind              = "PIPELINE"
  pipeline_config {
    functions = [
      "${aws_appsync_function.test1.function_id}",
      "${aws_appsync_function.test2.function_id}",
      "${aws_appsync_function.test3.function_id}"
    ]
  }
}