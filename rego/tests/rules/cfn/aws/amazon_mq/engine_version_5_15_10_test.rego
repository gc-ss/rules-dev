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

package rules.cfn_amazon_mq_engine_version_5_15_10

import data.tests.rules.cfn.amazon_mq.inputs

test_valid {
	pol = policy with input as inputs.valid.mock_input
	by_resource_id = {p.id: p.valid | pol[p]}
	count(by_resource_id) == 1
	by_resource_id.valid == true
}

test_invalid {
	pol = policy with input as inputs.invalid.mock_input
	by_resource_id = {p.id: p.valid | pol[p]}
	count(by_resource_id) == 1
	by_resource_id.invalid == false
}
