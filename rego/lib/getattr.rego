package fugue

getattr(obj, attribute, default_value) = ret {
	not contains(attribute, ".")
	ret = object.get(obj, attribute, default_value)
} else = ret {
	parts = split(attribute, ".")
	json_path = concat("/", ["", concat("/", parts)])
	patched = json.patch(obj, [{"op": "copy", "from": json_path, "path": "__value"}])
	ret = object.get(patched, "__value", default_value)
} else = ret {
	ret = default_value
}
