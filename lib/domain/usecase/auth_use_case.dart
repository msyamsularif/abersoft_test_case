import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:dartz/dartz.dart';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class AuthUseCase extends UseCase<AuthDataModel, AuthParams> {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthDataModel>> call(AuthParams params) {
    return authRepository.signIn(
      username: params.username,
      password: params.password,
    );
  }
}

class AuthParams extends Equatable {
  final String username;
  final String password;
  const AuthParams({
    required this.username,
    required this.password,
  });
  @override
  List<Object?> get props => [username, password];
}
