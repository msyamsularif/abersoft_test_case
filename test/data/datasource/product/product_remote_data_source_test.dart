import 'dart:convert';
import 'dart:io';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source_impl.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/fixture_render.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late ProductRemoteDataSourceImpl productDataSource;

  setUp(() {
    mockDio = MockDio();
    productDataSource = ProductRemoteDataSourceImpl(mockDio);
  });

  // Path file for mock data
  String filePath = '/path/to/mock_file.jpg';

  ProductDataModel tProductDataMode = ProductDataModel(
    id: 1,
    name: 'Product 1',
    imageUrl: filePath,
    desc: 'this is product 1',
  );

  group('Get All product', () {
    test(
      'should return a list of products',
      () async {
        // arrange
        when(mockDio.get(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: ConstantName.baseUrl + ConstantName.pathUrlProduct,
            ),
            data: json.decode(fixture('list_product_response.json')),
            statusCode: 200,
          ),
        );

        // act
        final result = await productDataSource.getAllProduct();

        // assert
        expect(result, isA<Right<Failure, ProductResponseDataModel>>());
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        when(mockDio.get(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: ConstantName.baseUrl + ConstantName.pathUrlProduct,
            ),
            data: json.decode(fixture('failure_response.json')),
            statusCode: 403,
          ),
        );

        // act
        final result = await productDataSource.getAllProduct();

        // assert
        expect(result, isA<Left<Failure, ProductResponseDataModel>>());
      },
    );
  });

  group('Create Product', () {
    test(
      'should return the product that was made',
      () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: ConstantName.baseUrl + ConstantName.pathUrlProduct,
            ),
            data: json.decode(fixture('product_response.json')),
            statusCode: 200,
          ),
        );

        IOOverrides.runZoned(() async {
          // act
          final result = await productDataSource.createProduct(
            name: tProductDataMode.name,
            image: File(tProductDataMode.imageUrl),
            desc: tProductDataMode.desc,
          );

          // assert
          expect(result, isA<Right<Failure, ProductDataModel>>());
        });
      },
    );
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
              path: ConstantName.baseUrl + ConstantName.pathUrlProduct,
            ),
            data: ServerFailure(),
            statusCode: 403,
          ),
        );

        // act
        final result = await productDataSource.createProduct(
          name: tProductDataMode.name,
          image: MockFile(),
          desc: tProductDataMode.desc,
        );

        // assert
        expect(result, isA<Left<Failure, ProductDataModel>>());
      },
    );
  });
}
