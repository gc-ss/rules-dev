import argparse
import csv
import yaml
from dataclasses import dataclass, asdict
from typing import List, Dict, Optional
from lib.language import normalize


_service_aliases = {
    "apigateway": "api_gateway",
    "apigatewayv2": "api_gateway_v2",
    "amazonmq": "amazon_mq",
}


@dataclass
class Rule:
    """
    Captures information about one rule.
    """

    name: str
    severity: str
    description: str
    rule_id: str
    service: str
    resource_types: Dict[str, str]
    resource_type_description: Dict[str, str]


def get_rule_path(name: str, provider: str, service: str, type_name: str) -> str:
    name_parts = normalize(name).split()
    ignore = {"doc", "db"}
    ignore.update(normalize(provider).split())
    ignore.update(normalize(service).split())
    ignore.update(normalize(type_name).split())
    unique_parts = []
    for part in name_parts:
        if part not in ignore:
            unique_parts.append(part)
    rego_name = "_".join(unique_parts)
    return f"{provider.lower()}/{service.lower()}/{rego_name}.rego"


def get_rules(metadata_path: str) -> List[Rule]:
    rules: List[Rule] = []
    with open(metadata_path, newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row["ready"].lower() not in ["1", "yes"]:
                continue
            resource_types = {}
            if row["cf_types"]:
                resource_types["cfn"] = row["cf_types"]
            if row["tf_types"]:
                resource_types["tf"] = row["tf_types"]
            fugue_type = row.get("fugue_type") or "Missing.Missing.Missing"
            provider, service, type_name = fugue_type.split(".")
            service = service.lower()
            if service in _service_aliases:
                service = _service_aliases[service]
            type_name_lower = type_name.lower()
            rules.append(
                Rule(
                    name=get_rule_path(row["name"], provider, service, type_name),
                    service=service.lower(),
                    severity=row.get("severity", "Low"),
                    rule_id=row["new_id"],
                    description=row["name"],
                    resource_types=resource_types,
                    resource_type_description={
                        "singular": type_name_lower,
                        "plural": type_name_lower + "s",
                    },
                )
            )
    return rules


def read_yaml(path: str):
    with open(path) as f:
        return yaml.load(f, Loader=yaml.FullLoader)


def write_yaml(path: str, data):
    with open(path, "w") as f:
        yaml.dump(data, f, sort_keys=True)


def main():
    parser = argparse.ArgumentParser(description="Generate rule metadata")
    parser.add_argument(
        "services",
        metavar="N",
        type=str,
        nargs="*",
        help="Services to include",
    )
    args = parser.parse_args()

    rules = dict((r.name, asdict(r)) for r in get_rules("metadata.csv"))

    services = set(args.services)
    if services:
        for name, rule in list(rules.items()):
            if rule["service"] not in services:
                rules.pop(name)

    for rule in rules.values():
        rule.pop("name")

    try:
        metadata = read_yaml("metadata.yaml")
    except:
        metadata = {"rules": {}}

    for name, rule in rules.items():
        if name not in metadata["rules"]:
            metadata["rules"][name] = rule

    write_yaml("metadata.yaml", metadata)


if __name__ == "__main__":
    main()
