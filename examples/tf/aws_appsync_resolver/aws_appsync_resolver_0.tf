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