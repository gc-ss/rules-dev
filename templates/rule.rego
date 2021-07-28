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
import data.fugue.getattr

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

resources = fugue.resources("{{ resource_type }}")

is_invalid(resource) {
{%- if not condition %}
    resource.TODO == "TODO" # FIXME
{%- elif condition[0] == "eq" %}
    getattr(resource, "{{ attribute }}", null) == {{ condition[1] }}
{%- elif condition[0] == "neq" %}
    getattr(resource, "{{ attribute }}", null) != {{ condition[1] }}
{%- elif condition[0] == "is_set" %}
    getattr(resource, "{{ attribute }}", null) != null
{%- elif condition[0] == "is_not_set" %}
    getattr(resource, "{{ attribute }}", null) == null
{%- elif condition[0] == "len" and condition[1] == "neq" %}
    count(getattr(resource, "{{ attribute }}", [])) != {{ condition[2] }}
{%- elif condition[0] == "len" and condition[1] == "eq" %}
    count(getattr(resource, "{{ attribute }}", [])) == {{ condition[2] }}
{%- endif %}
}

policy[p] {
	resource = resources[_]
	reason = is_invalid(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = resources[_]
	not is_invalid(resource)
	p = fugue.allow_resource(resource)
}
