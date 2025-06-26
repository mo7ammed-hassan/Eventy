T? getValue<T>(Map<String, dynamic> json, String key, {T? defaultValue}) {
  if (json.containsKey(key) && json[key] is T) {
    return json[key] as T;
  }
  return defaultValue;
}
