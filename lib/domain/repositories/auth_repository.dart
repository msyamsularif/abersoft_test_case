import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/domain/entities/auth_entite.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntitie>> signIn({
    required String username,
    required String password,
  });
}
