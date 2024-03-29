import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:search_app/features/search/data/models/api_carts.dart';

class CartRemoteDataSource {
  final String apiUrl;

  CartRemoteDataSource(this.apiUrl);

  Future<List<Cart>> fetchCarts(int limit, int skip) async {
    String apiUrl = 'https://dummyjson.com/carts?skip=$skip&limit=$limit';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<Cart> carts = [];
      for (var element in data['carts']) {
        carts.add(Cart.fromJson(element));
      }
      return carts;
    } else {
      throw Exception('Failed to load carts');
    }
  }
}
