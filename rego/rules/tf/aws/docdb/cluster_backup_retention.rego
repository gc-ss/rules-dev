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

package rules.tf_aws_docdb_cluster_backup_retention

import data.fugue.getattr

__rego__metadoc__ := {
	"id": "NEW_ca25",
	"title": "DocDB Clusters should have a backup retention period set",
	"description": "DocDB Clusters should have a backup retention period set",
	"custom": {
		"controls": {},
		"severity": "Medium",
	},
}

resource_type = "aws_docdb_cluster"

default deny = false

deny {
	getattr(input, "backup_retention_period", null) == null
}
