import 'package:equatable/equatable.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';

abstract class CartsState extends Equatable {
  const CartsState();

  @override
  List<Object> get props => [];
}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsLoaded extends CartsState {
  final List<Cart> carts;

  const CartsLoaded(this.carts);

  @override
  List<Object> get props => [carts];
}

class CartsError extends CartsState {
  final String message;

  const CartsError(this.message);

  @override
  List<Object> get props => [message];
}
