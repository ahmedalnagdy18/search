import 'package:search_app/features/search/data/data_sources/cart.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';
import 'package:search_app/features/search/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cart>> getCarts() async {
    try {
      return await remoteDataSource.fetchCarts();
    } catch (e) {
      throw e;
    }
  }
}
