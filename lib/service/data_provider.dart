import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max_cart/screens/model/item_model.dart';

class DataProvider {
  Future<List<Item>> fetchProducts(int limit) async {
    final String api = 'https://dummyjson.com/products?limit=$limit&skip=10';

    try {
      final response = await http.get(Uri.parse(api));

      // If the server returns a successful response
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productList = data['products'];
        print(productList);
        return productList.map((product) => Item.fromJson(product)).toList();
      } else {
        throw Exception('Error in the provider');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
