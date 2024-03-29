import 'package:search_app/features/search/data/models/api_carts.dart';
import 'package:search_app/features/search/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<List<Cart>> getCarts(CartEntity cartEntity);
}
