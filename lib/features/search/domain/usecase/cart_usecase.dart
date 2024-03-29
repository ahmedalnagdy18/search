import 'package:search_app/features/search/data/models/api_carts.dart';
import 'package:search_app/features/search/domain/entities/cart_entity.dart';
import 'package:search_app/features/search/domain/repositories/cart_repository.dart';

class CartUsecase {
  final CartRepository repository;

  CartUsecase({required this.repository});

  Future<List<Cart>> call(CartEntity cartEntity) async {
    try {
      return await repository.getCarts(cartEntity);
    } catch (e) {
      rethrow;
    }
  }
}
