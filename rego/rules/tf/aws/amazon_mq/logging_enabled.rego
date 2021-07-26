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

package rules.tf_aws_amazon_mq_logging_enabled

import data.fugue

__rego__metadoc__ := {
	"id": "NEW_65f7",
	"title": "AmazonMQ Broker should have logging enabled",
	"description": "AmazonMQ Broker should have logging enabled",
	"custom": {
		"controls": {},
		"severity": "Low",
	},
}

resource_type = "MULTIPLE"

brokers = fugue.resources("aws_mq_broker")

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
