import 'dart:convert';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source_impl.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/fixture_render.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthRemoteDataSourceImpl authDataSource;

  setUp(() {
    mockDio = MockDio();
    authDataSource = AuthRemoteDataSourceImpl(mockDio);
  });

  group('Authentication', () {
    test(
      'should be able to sign in and get token',
      () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: ConstantName.baseUrl + ConstantName.pathUrlLogin,
            ),
            data: json.decode(fixture('auth_response.json')),
            statusCode: 200,
          ),
        );

        // act
        final result = await authDataSource.signIn(
          username: 'abersoft',
          password: '12345678',
        );

        // assert
        expect(result, isA<Right<Failure, AuthDataModel>>());
      },
    );

    test('should return ServerFailure when auth token is null', () async {
      // arrange
      when(mockDio.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: ConstantName.baseUrl + ConstantName.pathUrlLogin,
          ),
          data: json.decode(fixture('failure_response.json')),
          statusCode: 403,
        ),
      );

      // act
      final result = await authDataSource.signIn(
        username: 'abersoft',
        password: '12345678',
      );

      // assert
      expect(result, isA<Left<Failure, AuthDataModel>>());
    });

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: ConstantName.baseUrl + ConstantName.pathUrlLogin,
            ),
            data: ServerFailure(),
            statusCode: 404,
          ),
        );

        // act
        final result = await authDataSource.signIn(
          username: 'abersoft',
          password: '12345678',
        );

        // assert
        expect(result, isA<Left<Failure, AuthDataModel>>());
      },
    );
  });
}
