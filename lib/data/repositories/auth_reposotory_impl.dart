import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:dartz/dartz.dart';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, AuthDataModel>> signIn(
      {required String username, required String password}) async {
    return authRemoteDataSource.signIn(username: username, password: password);
  }
}
