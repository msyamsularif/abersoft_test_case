import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthDataModel>> signIn({
    required String username,
    required String password,
  });
}
