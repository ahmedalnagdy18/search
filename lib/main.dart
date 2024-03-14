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
