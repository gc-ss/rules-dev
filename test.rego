package curtis

import data.fugue.resource_view.resource_view_input

foo := "42"

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
			"Properties": {"DomainName": "ok"},
			"Type": "AWS::CertificateManager::Certificate",
		},
	},
}
