extension JsonExtensions on Map<String, dynamic> {
  T? getValue<T>(String key, {T? defaultValue}) {
    if (containsKey(key) && this[key] is T) {
      return this[key] as T;
    }
    return defaultValue;
  }
}
