import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/data/repositories/product_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late ProductRepositoryImpl productRepositoryImpl;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(mockProductRemoteDataSource);
  });

  const tProductDataModel = ProductDataModel(
    id: 1,
    name: 'Product 1',
    imageUrl: 'https://via.placeholder.com/100x100',
    desc: 'this is product 1',
  );

  group('Create Product', () {
    test('should return the product that was made', () async {
      // arrange
      when(mockProductRemoteDataSource.createProduct(
        name: anyNamed('name'),
        image: anyNamed('image'),
        desc: anyNamed('desc'),
      )).thenAnswer(
        (_) async => const Right(tProductDataModel),
      );

      // act
      final result = await productRepositoryImpl.createProduct(
        name: tProductDataModel.name,
        image: MockFile(),
        desc: tProductDataModel.desc,
      );

      // assert
      expect(result, equals(const Right(tProductDataModel)));
    });

    test('should be able to sign in and get token', () async {
      // arrange
      when(mockProductRemoteDataSource.createProduct(
        name: anyNamed('name'),
        image: anyNamed('image'),
        desc: anyNamed('desc'),
      )).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      // act
      final result = await productRepositoryImpl.createProduct(
        name: tProductDataModel.name,
        image: MockFile(),
        desc: tProductDataModel.desc,
      );

      // assert
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
