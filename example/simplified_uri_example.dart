import 'package:simplified_uri/simplified_uri.dart';

void main() {
  final baseUrl = 'https://api.example.com';

  // Example 1: Simple flat map
  final uri1 = SimplifiedUri.uri('/users', {
    'page': 1,
    'limit': 10,
  });
  print('Flat map:\n$uri1\n');

  // Example 2: Nested map
  final uri2 = SimplifiedUri.uri('$baseUrl/profile', {
    'user': {
      'name': 'Alice',
      'email': 'alice@example.com',
    }
  });
  print('Nested map:\n$uri2\n');

  // Example 3: List of primitives
  final uri3 = SimplifiedUri.uri('$baseUrl/items', {
    'ids': [100, 101, 102],
  });
  print('List of primitives:\n$uri3\n');

  // Example 4: List of maps
  final uri4 = SimplifiedUri.uri('$baseUrl/batch', {
    'users': [
      {'id': 1, 'name': 'John'},
      {'id': 2, 'name': 'Jane'}
    ]
  });
  print('List of maps:\n$uri4\n');

  // Example 5: null value handling
  final uri5 = SimplifiedUri.uri('$baseUrl/search', {
    'query': null,
    'type': 'all'
  });
  print('Null values:\n$uri5\n');

  // Example 6: Entire param is null
  final uri6 = SimplifiedUri.uri('$baseUrl/ping', null);
  print('Null param:\n$uri6\n');
}
