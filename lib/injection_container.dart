import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source.dart';
import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source_impl.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source_impl.dart';
import 'package:abersoft_test_case/data/repositories/auth_reposotory_impl.dart';
import 'package:abersoft_test_case/data/repositories/product_repository_impl.dart';
import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';
import 'package:abersoft_test_case/domain/repositories/product_repository.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:abersoft_test_case/domain/usecase/create_product_use_case.dart';
import 'package:abersoft_test_case/domain/usecase/get_product_use_case.dart';
import 'package:abersoft_test_case/presentation/bloc/auth/auth_cubit.dart';
import 'package:abersoft_test_case/presentation/bloc/product/product_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // service locator data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // service locator repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  //service locator UseCase
  sl.registerFactory<AuthUseCase>(
    () => AuthUseCase(sl()),
  );
  sl.registerFactory<CreateProductUseCase>(
    () => CreateProductUseCase(sl()),
  );
  sl.registerFactory<GetProductUseCase>(
    () => GetProductUseCase(sl()),
  );

  // service locator cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(authUseCase: sl(), flutterSecureStorage: sl()),
  );
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(createProductUseCase: sl(), getProductUseCase: sl()),
  );
}
