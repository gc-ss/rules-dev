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

package rules.cfn_docdb_clusters_logging_enabled

import data.fugue

__rego__metadoc__ := {
	"id": "NEW_17ef",
	"title": "DocDB Clusters should have logging enabled",
	"description": "DocDB Clusters should have logging enabled",
	"custom": {
		"controls": {},
		"severity": "Low",
	},
}

input_type = "cfn"

resource_type = "MULTIPLE"

clusters = fugue.resources("AWS::DocDB::DBCluster")

is_invalid(resource) {
	false # TODO
}

policy[p] {
	resource = clusters[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = clusters[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}
