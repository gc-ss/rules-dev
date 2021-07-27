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

package rules.cfn_docdb_cluster_plaintext_password

__rego__metadoc__ := {
	"id": "NEW_a8ea",
	"title": "DocDB Clusters should not define a master password in plaintext",
	"description": "DocDB Clusters should not define a master password in plaintext",
	"custom": {
		"controls": {},
		"severity": "High",
	},
}

input_type = "cfn"

resource_type = "AWS::DocDB::DBCluster"

default allow = false

allow {
	input.TODO == true
}
