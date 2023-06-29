import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late AuthUseCase authUseCase;

  setUp(() {
    authRepository = MockAuthRepository();
    authUseCase = AuthUseCase(authRepository);
  });

  const tAuthDataModel = AuthDataModel(token: '123123123123123123123');

  test('should be able to sign in from the repository', () async {
    // arrange
    when(authRepository.signIn(
      username: anyNamed('username'),
      password: anyNamed('password'),
    )).thenAnswer(
      (_) async => const Right(tAuthDataModel),
    );

    // act
    final result = await authUseCase(
      const AuthParams(username: 'abersoft', password: '12345678'),
    );

    // assert
    expect(result, const Right(tAuthDataModel));
    verify(authRepository.signIn(username: 'abersoft', password: '12345678'));
    verifyNoMoreInteractions(authRepository);
  });
}
