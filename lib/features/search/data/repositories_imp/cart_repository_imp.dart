import 'package:search_app/features/search/data/data_sources/cart.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';
import 'package:search_app/features/search/domain/entities/cart_entity.dart';
import 'package:search_app/features/search/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cart>> getCarts(CartEntity cartEntity) async {
    try {
      return await remoteDataSource.fetchCarts(
          cartEntity.limit, cartEntity.skip);
    } catch (e) {
      rethrow;
    }
  }
}
