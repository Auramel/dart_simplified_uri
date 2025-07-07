📦 Simplified uri
=================

A lightweight Dart utility for building URLs with deeply nested query parameters from `Map` and `List` objects.

Perfect for building REST API queries, especially when dealing with complex structures like:

    {
      "filter": {
        "status": "active",
        "tags": ["dart", "flutter"]
      },
      "page": 1
    }

This will generate:

    ?filter[status]=active&filter[tags][0]=dart&filter[tags][1]=flutter&page=1

🚀 Features
-----------

*   ✅ Converts nested `Map<String, dynamic>` and `List` to query string
*   ✅ Automatically encodes values using `Uri.encodeQueryComponent`
*   ✅ Supports null values (encoded as empty strings)
*   ✅ Lightweight and dependency-free

🛠 Usage
--------

    import 'package:simplified_uri/simplified_uri.dart';
    
    void main() {
      final url = SimplifiedUri.uri(
        'https://api.example.com',
        {
          'search': 'example',
          'filters': {
            'tags': ['flutter', 'dart'],
            'status': 'active',
          },
          'page': 1,
        },
      );
    
      print(url);
      // Output:
      // https://api.example.com?search=example&filters[tags][0]=flutter&filters[tags][1]=dart&filters[status]=active&page=1
    }