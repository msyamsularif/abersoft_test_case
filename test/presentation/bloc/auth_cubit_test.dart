import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:abersoft_test_case/presentation/bloc/auth/auth_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthUseCase mockAuthUseCase;
  late AuthCubit authCubit;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    authCubit = AuthCubit(
      authUseCase: mockAuthUseCase,
      flutterSecureStorage: mockFlutterSecureStorage,
    );
  });

  const tAuthDataModel = AuthDataModel(token: '123123123123123123123');

  test('initial state should be empty', () {
    expect(authCubit.state, AuthInitial());
  });

  group('sign auth cubit', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthLoaded] when data is gotten successfully.',
      build: () {
        when(mockAuthUseCase(
          const AuthParams(username: 'abersoft', password: '12345678'),
        )).thenAnswer((_) async => const Right(tAuthDataModel));

        return authCubit;
      },
      act: (bloc) => bloc.signIn(username: 'abersoft', password: '12345678'),
      expect: () => <AuthState>[
        AuthLoading(),
        AuthLoaded(token: tAuthDataModel.token!),
      ],
      verify: (bloc) {
        verify(
          mockAuthUseCase(
            const AuthParams(username: 'abersoft', password: '12345678'),
          ),
        );
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthFailure] when data is not success.',
      build: () {
        when(mockAuthUseCase(
          const AuthParams(username: 'abersoft', password: '12345678'),
        )).thenAnswer((_) async => Left(ServerFailure()));

        return authCubit;
      },
      act: (bloc) => bloc.signIn(username: 'abersoft', password: '12345678'),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailure(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockAuthUseCase(
            const AuthParams(username: 'abersoft', password: '12345678'),
          ),
        );
      },
    );
  });
}
