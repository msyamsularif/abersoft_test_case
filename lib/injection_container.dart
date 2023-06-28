import 'package:abersoft_test_case/data/datasource/auth_remote_data_source.dart';
import 'package:abersoft_test_case/data/datasource/auth_remote_data_source_impl.dart';
import 'package:abersoft_test_case/data/repositories/auth_reposotory_impl.dart';
import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:abersoft_test_case/presentation/bloc/auth/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  // service locator data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // service locator repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  //service locator UseCase
  sl.registerFactory<AuthUseCase>(() => AuthUseCase(sl()));

  // service locator cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(authRepository: sl()));
}
