import 'package:search_app/features/search/data/models/api_carts.dart';

abstract class CartsState {
  const CartsState();
}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsLoaded extends CartsState {
  final List<Cart> carts;

  const CartsLoaded(this.carts);
}

class PaginationCarts extends CartsState {
  final List<Cart> carts;

  const PaginationCarts(this.carts);
}

class CartsError extends CartsState {
  final String message;

  const CartsError(this.message);
}

class Cartsadded extends CartsState {
  final List<Product> products;

  const Cartsadded(this.products);
}
