/// A utility class to convert nested Maps and Lists into URL query strings.
/// This is useful for APIs, Telegram Mini Apps, and backends that accept
/// PHP-style query parameters (e.g., `param[key]=value`).
abstract class SimplifiedUri {
  /// Builds a [Uri] from the given [url] and [param] object.
  /// The [param] can be a Map or List with any nesting level.
  static Uri uri(final String url, final dynamic param) {
    final query = _objectToQueryString(param);
    final urlString = query.isEmpty ? '$url?' : '$url?$query';
    return Uri.parse(urlString);
  }

  /// Converts a nested Map or List to a query string.
  /// Supports complex nested structures.
  static String _objectToQueryString(final dynamic json) {
    if (json == null) {
      return '';
    }

    final List<String> queries = [];

    if (json is Map) {
      for (final key in json.keys) {
        final dynamic value = json[key];

        if (value is Map) {
          // Recursively handle nested Map
          _generateInnerMap(queries, key.toString(), value);
        } else if (value is List) {
          // Handle List under this key
          _generateInnerList(queries, key.toString(), value);
        } else {
          // Encode a simple key-value pair
          final String k = Uri.encodeQueryComponent(key.toString());
          final String v = value == null ? '' : Uri.encodeQueryComponent(value.toString());
          queries.add('$k=$v');
        }
      }
    } else if (json is List) {
      // Handle root-level List
      _generateInnerList(queries, '', json);
    }

    return queries.join('&');
  }

  /// Recursively processes nested Maps to flatten them into query strings.
  static void _generateInnerMap(
    final List<String> queryList,
    final String parentKey,
    final Map<dynamic, dynamic> innerJson,
  ) {
    for (final key in innerJson.keys) {
      final dynamic value = innerJson[key];
      final String fullKey = '$parentKey[$key]';

      if (value is Map) {
        // Handle deeper nested Map
        _generateInnerMap(queryList, fullKey, value);
      } else if (value is List) {
        // Handle List inside Map
        _generateInnerList(queryList, fullKey, value);
      } else {
        // Encode simple key-value pair inside Map
        final String k = Uri.encodeQueryComponent(key.toString());
        final String v = value == null ? '' : Uri.encodeQueryComponent(value.toString());
        queryList.add('$parentKey[$k]=$v');
      }
    }
  }

  /// Recursively processes nested Lists to flatten them into query strings.
  static void _generateInnerList(
    final List<String> queryList,
    final String parentKey,
    final List<dynamic> innerList,
  ) {
    for (int i = 0; i < innerList.length; i++) {
      final dynamic item = innerList[i];
      final String fullKey = '$parentKey[$i]';

      if (item is Map) {
        // Handle Map inside List
        _generateInnerMap(queryList, fullKey, item.cast<String, dynamic>());
      } else {
        // Encode List item
        final v = item == null ? '' : Uri.encodeQueryComponent(item.toString());
        queryList.add('$fullKey=$v');
      }
    }
  }
}
