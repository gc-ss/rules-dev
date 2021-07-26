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

{% if input_type == "cfn" %}
package rules.{{ input_type }}_{{ service }}_{{ name }}
{% else %}
package rules.{{ input_type }}_{{ provider }}_{{ service }}_{{ name }}
{% endif %}

import data.fugue

__rego__metadoc__ := {
	"id": "{{ id }}",
	"title": "{{ title }}",
    "description": "{{ description }}",
    "custom": {
		"controls": {},
		"severity": "{{ severity }}",
	},
}

{% if input_type != "tf" %}
input_type = "{{ input_type }}"
{% endif %}

resource_type = "MULTIPLE"

{{ plural_name }} = fugue.resources("{{ resource_type }}")

is_invalid(resource) {
    false # TODO
}

policy[p] {
	resource = {{ plural_name }}[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = {{ plural_name }}[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}