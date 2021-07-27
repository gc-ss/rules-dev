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

package rules.cfn_amazon_mq_broker_engine_version

__rego__metadoc__ := {
	"id": "NEW_ccf7",
	"title": "AmazonMQ Broker engine version should be at least 5.15.10",
	"description": "AmazonMQ Broker engine version should be at least 5.15.10",
	"custom": {
		"controls": {},
		"severity": "Medium",
	},
}

input_type = "cfn"

resource_type = "AWS::AmazonMQ::Broker"

default deny = false

deny {
	input.TODO == "TODO"
}
