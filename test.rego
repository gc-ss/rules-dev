package curtis

obj := {"foo": {"bar": 42}}

# getattr(obj, attribute) = ret {
# 	parts = split(attribute, ".")
# 	count(parts) == 1
# 	ret = object.get(obj, attribute, null)
# } else = ret {
# 	parts = split(attribute, ".")
# 	count(parts) == 2
# 	rest = concat(".", array.slice(parts, 1, count(parts)))
# 	nested_obj = object.get(obj, parts[0], {})
# 	is_object(nested_obj)
# 	ret = object.get(nested_obj, rest, null)
# } else = ret {
# 	ret = null
# }

getattr(obj, attribute) = ret {
	not contains(attribute, ".")
	ret = object.get(obj, attribute, null)
} else = ret {
	parts = split(attribute, ".")
	json_path = concat("/", ["", concat("/", parts)])
	patched = json.patch(obj, [{"op": "copy", "from": json_path, "path": "__value"}])
	ret = object.get(patched, "__value", null)
} else = ret {
	ret = null
}
