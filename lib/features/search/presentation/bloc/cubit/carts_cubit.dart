import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';
import 'package:search_app/features/search/domain/entities/cart_entity.dart';
import 'package:search_app/features/search/domain/usecase/cart_usecase.dart';
import 'package:search_app/features/search/presentation/bloc/cubit/carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final CartUsecase cartUsecase;
  List<Cart> carts = [];
  int skip = 0;
  List<Product> story = [];
  CartsCubit(this.cartUsecase) : super(CartsInitial());

  Future<void> getCarts() async {
    emit(CartsLoading());
    try {
      carts = await cartUsecase(CartEntity());
      emit(CartsLoaded(carts));
    } catch (e) {
      emit(CartsError('Failed to load carts: $e'));
    }
  }

  Future<void> paginateCarts() async {
    try {
      carts.addAll(await cartUsecase(CartEntity(skip, 10)));
      if (skip == 0) {
        skip = 10;
      } else {
        skip = 0;
      }
    } catch (e) {
      emit(CartsError('Failed to load carts: $e'));
    }
  }

  void addToStory(Product product) {
    if (product.stutas == false) {
      product.stutas = true;
      story.add(product);
    } else {
      product.stutas = false;
      story.remove(product);
    }
    emit(Cartsadded(story));
  }
}
