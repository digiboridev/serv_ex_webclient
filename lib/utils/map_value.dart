T? getMapValue<T>(dynamic map, String key) {
  if (map is Map && map.containsKey(key)) {
    var value = map[key];
    if (value is T) {
      return value;
    }
  }
  return null;
}
