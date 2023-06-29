import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/usecase/get_product_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRepository productRepository;
  late GetProductUseCase getProductUseCase;

  setUp(() {
    productRepository = MockProductRepository();
    getProductUseCase = GetProductUseCase(productRepository);
  });

  const tProduct = ProductResponseDataModel(
    bestProducts: [
      ProductDataModel(
        id: 1,
        name: 'Product 1',
        imageUrl: 'https://via.placeholder.com/100x100',
        desc: 'this is product 1',
      )
    ],
    allProducts: [
      ProductDataModel(
        id: 1,
        name: 'Product 1',
        imageUrl: 'https://via.placeholder.com/100x100',
        desc: 'this is product 1',
      )
    ],
  );

  test('should be able to sign in from the repository', () async {
    // arrange
    when(productRepository.getAllProduct()).thenAnswer(
      (_) async => const Right(tProduct),
    );

    // act
    final result = await getProductUseCase(NoParams());

    // assert
    expect(result, const Right(tProduct));
    verify(productRepository.getAllProduct());
    verifyNoMoreInteractions(productRepository);
  });
}
