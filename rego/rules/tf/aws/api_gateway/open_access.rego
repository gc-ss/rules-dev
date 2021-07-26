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

package rules.tf_aws_api_gateway_open_access

import data.fugue

__rego__metadoc__ := {
	"id": "NEW_4a01",
	"title": "API Gateway Method should not have open access",
	"description": "API Gateway Method should not have open access",
	"custom": {
		"controls": {},
		"severity": "Low",
	},
}

resource_type = "MULTIPLE"

methods = fugue.resources("aws_api_gateway_method")

is_invalid(resource) {
	false # TODO
}

policy[p] {
	resource = methods[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = methods[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}
