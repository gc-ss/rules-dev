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

package rules.tf_aws_api_gateway_stage_xray_tracing_enabled

import data.rego.tests.rules.tf.aws.api_gateway.stage_xray_tracing_enabled as inputs

test_valid {
	resources = inputs.mock_resources
	not deny with input as resources.valid
}

test_invalid {
	resources = inputs.mock_resources
	deny with input as resources.invalid
}