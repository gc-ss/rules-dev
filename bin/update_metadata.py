import argparse
import csv
import yaml
from dataclasses import dataclass, asdict
from typing import Any, Dict, List, Optional


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
    path: str
    severity: str
    summary: str
    description: str
    rule_id: str
    service: str
    provider: str
    rule_type: str
    runtime: bool
    input_types: Dict[str, Dict[str, Any]]


def get_rule_path(provider: str, service: str, name: str) -> str:
    return f"{provider.lower()}/{service.lower()}/{name}.rego"


def types_from_field(type_str: str) -> List[str]:
    return [t.strip() for t in type_str.split(",")]


def get_rules(metadata_path: str) -> List[Rule]:
    rules: List[Rule] = []
    with open(metadata_path, newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row["status"] != "ready":
                continue
            input_types = {}
            if row["cfn"] == "yes":
                input_types["cfn"] = {
                    "resource_type": types_from_field(row["cfn_type"])[0],
                    "attribute": row["cfn_attr"] or None,
                    "condition": row["cfn_condition"] or None,
                }
            if row["tf"] == "yes":
                input_types["tf"] = {
                    "resource_type": types_from_field(row["tf_type"])[0],
                    "attribute": row["tf_attr"] or None,
                    "condition": row["tf_condition"] or None,
                }
            fugue_type = row["resource_type"]
            provider, service, type_name = fugue_type.split(".")
            service = service.lower()
            if service in _service_aliases:
                service = _service_aliases[service]
            rules.append(
                Rule(
                    rule_type=row["rule_type"],
                    name=row["name"],
                    path=get_rule_path(provider, service, row["name"]),
                    provider=provider.lower(),
                    service=service.lower(),
                    severity=row["severity"],
                    rule_id=row["rule_id"],
                    runtime=row["runtime"] == "yes",
                    summary=row["summary"],
                    description=row["description"] or row["summary"],
                    input_types=input_types,
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

    rules = dict((r.path, asdict(r)) for r in get_rules("metadata.csv"))

    services = set(args.services)
    if services:
        for name, rule in list(rules.items()):
            if rule["service"] not in services:
                rules.pop(name)

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
