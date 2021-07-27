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

provider "aws" {
  region = "us-east-1"
}

resource "{{ resource_type }}" "valid" {
{% if condition and condition[0] == "eq" %}
    {{ attribute }} = "not {{ condition[1] }}"
{% elif condition and condition[0] == "neq" %}
    {{ attribute }} = "{{ condition[1] }}"
{% endif %}
}

resource "{{ resource_type }}" "invalid" {
{% if condition and condition[0] == "eq" %}
    {{ attribute }} = "{{ condition[1] }}"
{% elif condition and condition[0] == "neq" %}
    {{ attribute }} = "not {{ condition[1] }}"
{% endif %}
}
