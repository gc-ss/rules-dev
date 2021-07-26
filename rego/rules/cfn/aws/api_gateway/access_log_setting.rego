# Copyright 2021 Fugue, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package rules.cfn_api_gateway_access_log_setting

import data.fugue

__rego__metadoc__ := {
	"id": "NEW_661e",
	"title": "API Gateway Deployment should have an access log setting",
	"description": "API Gateway Deployment should have an access log setting",
	"custom": {
		"controls": {},
		"severity": "Low",
	},
}

input_type = "cfn"

resource_type = "MULTIPLE"

deployments = fugue.resources("AWS::ApiGateway::Deployment")

is_invalid(resource) {
	false # TODO
}

policy[p] {
	resource = deployments[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = deployments[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}
