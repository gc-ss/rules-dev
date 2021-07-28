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

resource_type = "{{ resource_type }}"

default deny = false

deny {
{%- if not condition %}
    input.TODO == "TODO" # FIXME
{%- elif condition[0] == "eq" %}
    object.get(input, "{{ attribute }}", null) == {{ condition[1] }}
{%- elif condition[0] == "neq" %}
    object.get(input, "{{ attribute }}", null) != {{ condition[1] }}
{%- elif condition[0] == "is_set" %}
    object.get(input, "{{ attribute }}", "_UNSET_") != "_UNSET_"
{%- elif condition[0] == "is_not_set" %}
    object.get(input, "{{ attribute }}", "_UNSET_") == "_UNSET_"
{%- elif condition[0] == "len" and condition[1] == "neq" %}
    count(object.get(input, "{{ attribute }}", [])) != {{ condition[2] }}
{%- elif condition[0] == "len" and condition[1] == "eq" %}
    count(object.get(input, "{{ attribute }}", [])) == {{ condition[2] }}
{%- endif %}
}
