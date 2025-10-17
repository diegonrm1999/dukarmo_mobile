extension MapExtesion on Map {
  List<T>? toListFromMap<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    var toConvert = this[key];
    if (toConvert == null) {
      return null;
    }

    // We play it safe, first convert to nullable map and exclude nulls
    return List<Map<String, dynamic>?>.from(toConvert)
        .whereType<Map<String, dynamic>>()
        .map(fromJson)
        .toList();
  }

  List<T>? toListFrom<T>(String key) {
    var toConvert = this[key];
    if (toConvert == null) {
      return null;
    }
    // We play it safe, first convert to nullable list of T and exclude nulls
    // We observed lists that come from the api with mixed Strings / nulls
    // Shop productsTag for instance
    return List<T?>.from(toConvert).whereType<T>().toList();
  }

  T? toEntityFromMap<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    var toConvert = this[key];
    if (toConvert == null) {
      return null;
    }
    return fromJson(this[key]);
  }

  Map<T, V>? toMapFrom<T, V>(String key) {
    var toConvert = this[key];
    if (toConvert == null) {
      return null;
    }

    Map<T, V> typedMap = {};
    toConvert.forEach(
      (key, value) {
        if (value is num && V == double) {
          typedMap[key] = value.toDouble() as V;
        } else {
          typedMap[key] = value;
        }
      },
    );
    return typedMap;
  }

  double? getDouble(String key) {
    var toConvert = this[key];
    if (toConvert == null) {
      return null;
    }

    return (toConvert as num?)?.toDouble();
  }
}
