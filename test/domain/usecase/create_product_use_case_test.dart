import 'dart:io';

import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/usecase/create_product_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRepository productRepository;
  late CreateProductUseCase createProductUseCase;

  setUp(() {
    productRepository = MockProductRepository();
    createProductUseCase = CreateProductUseCase(productRepository);
  });

  const tProduct = ProductDataModel(
    id: 1,
    name: 'Product 1',
    imageUrl: 'https://via.placeholder.com/100x100',
    desc: 'this is product 1',
  );

  test('should be able to sign in from the repository', () async {
    // arrange
    when(productRepository.createProduct(
      name: anyNamed('name'),
      image: anyNamed('image'),
      desc: anyNamed('desc'),
    )).thenAnswer(
      (_) async => const Right(tProduct),
    );

    // act
    final result = await createProductUseCase(
      CreateProductParam(
        id: 1,
        name: 'Product 1',
        image: File('https://via.placeholder.com/100x100'),
        desc: 'this is product 1',
      ),
    );

    // assert
    expect(result, const Right(tProduct));
  });
}
