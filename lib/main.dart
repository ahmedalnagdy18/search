import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/constant/strings.dart';
import 'package:search_app/features/search/data/data_sources/cart.dart';

import 'package:search_app/features/search/data/repositories_imp/cart_repository_imp.dart';
import 'package:search_app/features/search/domain/usecase/cart_usecase.dart';
import 'package:search_app/features/search/presentation/bloc/cubit/carts_cubit.dart';
import 'package:search_app/features/search/presentation/pages/search_page.dart';

void main() {
  // init();
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CartsCubit>(
        create: (context) => CartsCubit(CartUsecase(
            repository: CartRepositoryImpl(CartRemoteDataSource(baseUrl))))
          ..getCarts(),
        child: const SearchPage(),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // TODO: implement onEvent
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // TODO: implement onChange
  }
}
