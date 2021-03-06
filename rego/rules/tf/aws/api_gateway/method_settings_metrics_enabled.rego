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

package rules.tf_aws_api_gateway_method_settings_metrics_enabled

import data.fugue.getattr

__rego__metadoc__ := {
	"id": "NEW_73db",
	"title": "API Gateway Method Settings should have CloudWatch metrics enabled",
	"description": "API Gateway Method Settings should have CloudWatch metrics enabled",
	"custom": {
		"controls": {},
		"severity": "Medium",
	},
}

resource_type = "aws_api_gateway_method_settings"

default deny = false

deny {
	getattr(input, "settings.metrics_enabled", null) != true
}
