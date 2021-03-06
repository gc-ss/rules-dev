# Copyright 2020-2021 Fugue, Inc.
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
package rego.tests.rules.tf.aws.docdb.cluster_backup_retention_tf

import data.fugue.resource_view.resource_view_input

mock_input := ret {
	ret = resource_view_input with input as mock_config
}

mock_resources := mock_input.resources

mock_config := {
	"hcl_resource_view_version": "0.0.1",
	"resources": {
		"aws_docdb_cluster.invalid": {
			"_filepath": "rego/tests/rules/tf/aws/docdb/cluster_backup_retention.tf",
			"_provider": "aws",
			"_type": "aws_docdb_cluster",
			"backup_retention_period": "PLACEHOLDER",
			"id": "aws_docdb_cluster.invalid",
		},
		"aws_docdb_cluster.valid": {
			"_filepath": "rego/tests/rules/tf/aws/docdb/cluster_backup_retention.tf",
			"_provider": "aws",
			"_type": "aws_docdb_cluster",
			"backup_retention_period": "PLACEHOLDER",
			"id": "aws_docdb_cluster.valid",
		},
	},
}
