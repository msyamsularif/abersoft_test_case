import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:abersoft_test_case/data/repositories/auth_reposotory_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthRemoteDataSource);
  });

  const tAuthDataModel = AuthDataModel(token: '123123123123123123123');

  group('Sign In', () {
    test('should be able to sign in and get token', () async {
      // arrange
      when(mockAuthRemoteDataSource.signIn(
        username: 'abersoft',
        password: '12345678',
      )).thenAnswer(
        (_) async => const Right(tAuthDataModel),
      );

      // act
      final result = await authRepositoryImpl.signIn(
        username: 'abersoft',
        password: '12345678',
      );

      // assert
      expect(result, equals(const Right(tAuthDataModel)));
    });

    test('should be able to sign in and get token', () async {
      // arrange
      when(mockAuthRemoteDataSource.signIn(
        username: 'abersoft',
        password: '12345678',
      )).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      // act
      final result = await authRepositoryImpl.signIn(
        username: 'abersoft',
        password: '12345678',
      );

      // assert
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
