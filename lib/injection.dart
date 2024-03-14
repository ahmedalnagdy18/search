// import 'package:get_it/get_it.dart';
// import 'package:search_app/features/search/data/data_sources/cart.dart';
// import 'package:search_app/features/search/data/repositories_imp/cart_repository_imp.dart';
// import 'package:search_app/features/search/domain/repositories/cart_repository.dart';
// import 'package:search_app/features/search/domain/usecase/cart_usecase.dart';
// import 'package:http/http.dart' as http;

// final sl = GetIt.instance;

// Future<void> init() async {
//   // Registering DataSources
//   sl.registerLazySingleton<CartRemoteDataSource>(
//       () => CartRemoteDataSource("https://dummyjson.com/carts"));

//   // Registering Repository
//   sl.registerLazySingleton<CartRepository>(
//       () => CartRepositoryImpl(sl<CartRemoteDataSource>()));

//   // Registering Usecases
//   sl.registerLazySingleton<CartUsecase>(
//       () => CartUsecase(repository: sl<CartRepository>()));

//   // Optional: If you need to use the HTTP client elsewhere, you can register it too
//   sl.registerLazySingleton<http.Client>(() => http.Client());
// }
