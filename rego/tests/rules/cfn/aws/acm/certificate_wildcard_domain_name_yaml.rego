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
package rego.tests.rules.cfn.aws.acm.certificate_wildcard_domain_name_yaml

import data.fugue.resource_view.resource_view_input

mock_input := ret {
	ret = resource_view_input with input as mock_config
}

mock_resources := mock_input.resources

mock_config := {
	"AWSTemplateFormatVersion": "2010-09-09",
	"Description": "Regula Test Input",
	"Resources": {
		"invalid": {
			"Properties": {"DomainName": "*"},
			"Type": "AWS::CertificateManager::Certificate",
		},
		"valid": {
			"Properties": {"DomainName": "PLACEHOLDER"},
			"Type": "AWS::CertificateManager::Certificate",
		},
	},
}
