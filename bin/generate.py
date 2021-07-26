"""
Generates a skeleton for each rule defined in metadata.yaml. Outputs rego code
and empty test inputs in rego/rules and rego/tests.
"""
import argparse
import os
from subprocess import run
from typing import Dict, Any, Tuple
import jinja2
import yaml
from jinja2 import Environment, FileSystemLoader, select_autoescape

env = Environment(
    loader=FileSystemLoader("templates"),
    autoescape=select_autoescape(),
)

rule_template = env.get_template("rule.rego")
test_template = env.get_template("rule_test.rego")
test_tf_template = env.get_template("test_resource.tf")
test_cfn_template = env.get_template("test_resource.yaml")


def repo_root() -> str:
    args = ["git", "rev-parse", "--show-toplevel"]
    return run(args, check=True, capture_output=True).stdout.decode().strip()


def read_metadata() -> Dict[str, Any]:
    with open(os.path.join(repo_root(), "metadata.yaml")) as f:
        return yaml.load(f, Loader=yaml.FullLoader)


def rule_dirs(path: str, input_type: str) -> Tuple[str, str]:
    dir_part, filename = os.path.split(path)
    rego_dir = os.path.join(repo_root(), "rego")
    rule_dir = os.path.join(rego_dir, "rules", input_type, dir_part)
    test_dir = os.path.join(rego_dir, "tests", "rules", input_type, dir_part)
    return (rule_dir, test_dir)


def render(template: jinja2.Template, path: str, force: bool, **kwargs):
    if not force and os.path.exists(path):
        print("Already exists:", path)
        return
    with open(path, "w") as f:
        f.write(template.render(**kwargs))
    print("Wrote:", path)


def generate_rule(path: str, rule: Dict[str, Any], force: bool = False):
    provider, service, filename = path.split("/")
    name = filename.split(".")[0]
    for input_type, resource_type in rule["resource_types"].items():
        rule_dir, test_dir = rule_dirs(path, input_type)
        os.makedirs(rule_dir, exist_ok=True)
        os.makedirs(test_dir, exist_ok=True)
        rule_data = dict(
            input_type=input_type,
            id=rule["rule_id"],
            title=rule.get("title") or rule["description"].split(".")[0],
            description=rule["description"],
            severity=rule["severity"],
            plural_name=rule["resource_type_description"]["plural"],
            singular_name=rule["resource_type_description"]["singular"],
            resource_type=resource_type,
            provider=provider,
            service=service,
            name=name,
        )
        # Render the rule rego
        render(
            rule_template,
            os.path.join(rule_dir, filename),
            force=force,
            **rule_data,
        )
        # Render the rule test
        render(
            test_template,
            os.path.join(test_dir, f"{name}_test.rego"),
            force=force,
            **rule_data,
        )
        # Render test input files
        if input_type == "tf":
            render(
                test_tf_template,
                os.path.join(test_dir, f"{name}.tf"),
                force=force,
                **rule_data,
            )
        elif input_type == "cfn":
            render(
                test_cfn_template,
                os.path.join(test_dir, f"{name}.yaml"),
                force=force,
                **rule_data,
            )


def main():
    parser = argparse.ArgumentParser(description="Generate rule skeletons")
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        default=False,
        help="Force overwrite existing files",
    )
    args = parser.parse_args()

    for rule_path, rule in read_metadata()["rules"].items():
        generate_rule(rule_path, rule, force=args.force)


if __name__ == "__main__":
    main()
