import 'package:test/test.dart';

import 'package:simplified_uri/simplified_uri.dart';

void main() {
  final String baseUrl = 'https://api.example.com';

  group('SimplifiedUri.uri', () {
    
    test('Flat map (no nesting)', () {
      // Tests a simple key-value map (no nested structures)
      final uri = SimplifiedUri.uri(baseUrl, {
        'name': 'John',
        'age': 30
      });

      expect(uri.toString(), '$baseUrl?name=John&age=30');
    });

    test('Nested map', () {
      // Tests handling of a nested map structure
      final uri = SimplifiedUri.uri(baseUrl, {
        'user': {
          'name': 'Alice',
          'email': 'alice@example.com',
        }
      });

      expect(uri.toString(), '$baseUrl?user%5Bname%5D=Alice&user%5Bemail%5D=alice%40example.com');
    });

    test('List of primitives', () {
      // Tests a list of numbers as a value
      final uri = SimplifiedUri.uri(baseUrl, {
        'ids': [1, 2, 3],
      });

      expect(uri.toString(), '$baseUrl?ids%5B0%5D=1&ids%5B1%5D=2&ids%5B2%5D=3');
    });

    test('List of maps', () {
      // Tests a list of maps (e.g. array of objects)
      final uri = SimplifiedUri.uri(baseUrl, {
        'items': [
          {'id': 1, 'name': 'Item1'},
          {'id': 2, 'name': 'Item2'},
        ]
      });

      expect(uri.toString(), '$baseUrl?items%5B0%5D%5Bid%5D=1&items%5B0%5D%5Bname%5D=Item1&items%5B1%5D%5Bid%5D=2&items%5B1%5D%5Bname%5D=Item2');
    });

    test('Map with null value', () {
      // Ensures null values in the map are represented correctly as empty strings
      final uri = SimplifiedUri.uri(baseUrl, {
        'name': null,
        'age': 25
      });

      expect(uri.toString(), '$baseUrl?name=&age=25');
    });

    test('Null parameter object', () {
      // Tests the case where the input object is completely null
      final uri = SimplifiedUri.uri(baseUrl, null);
      expect(uri.toString(), '$baseUrl?');
    });

    test('Empty map', () {
      // Tests an empty map as input
      final uri = SimplifiedUri.uri(baseUrl, {});
      expect(uri.toString(), '$baseUrl?');
    });

    test('Empty list', () {
      // Tests a key with an empty list as its value
      final uri = SimplifiedUri.uri(baseUrl, {
        'list': []
      });

      expect(uri.toString(), '$baseUrl?');
    });

    test('List with null elements', () {
      // Tests a list that includes null values among valid ones
      final uri = SimplifiedUri.uri(baseUrl, {
        'items': [null, 42]
      });

      expect(uri.toString(), '$baseUrl?items%5B0%5D=&items%5B1%5D=42');
    });
  });
}
