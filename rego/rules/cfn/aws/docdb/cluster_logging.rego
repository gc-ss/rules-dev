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

package rules.cfn_docdb_cluster_logging

__rego__metadoc__ := {
	"id": "NEW_17ef",
	"title": "DocDB Clusters should have logging enabled",
	"description": "DocDB Clusters should have logging enabled",
	"custom": {
		"controls": {},
		"severity": "Medium",
	},
}

input_type = "cfn"

resource_type = "AWS::DocDB::DBCluster"

default deny = false

deny {
	input.TODO == "TODO"
}
