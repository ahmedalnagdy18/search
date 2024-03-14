// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:search_app/features/search/domain/entities/cart_entity.dart';
// import 'package:search_app/features/search/domain/usecase/cart_usecase.dart';
// import 'package:search_app/features/search/presentation/bloc/cubit/carts_state.dart';

// class CartsCubit extends Cubit<CartsState> {
//   final CartUsecase cartUsecase;

//   CartsCubit(this.cartUsecase) : super(CartsInitial());

//   Future<void> getCarts() async {
//     emit(CartsLoading());
//     try {
//       final carts = await cartUsecase(CartEntity(total: 10, limit: 10));
//       emit(CartsLoaded(carts));
//     } catch (e) {
//       emit(CartsError('Failed to load carts: $e'));
//     }
//   }
// }
