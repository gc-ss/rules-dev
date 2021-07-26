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

package rules.cfn_amazon_mq_publicly_exposed

import data.fugue

__rego__metadoc__ := {
	"id": "NEW_2267",
	"title": "AmazonMQ Broker should not be publicly exposed",
	"description": "AmazonMQ Broker should not be publicly exposed",
	"custom": {
		"controls": {},
		"severity": "Low",
	},
}

input_type = "cfn"

resource_type = "MULTIPLE"

brokers = fugue.resources("AWS::AmazonMQ::Broker")

is_invalid(resource) {
	false # TODO
}

policy[p] {
	resource = brokers[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = brokers[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}
