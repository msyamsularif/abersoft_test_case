import 'dart:io';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/presentation/bloc/product/product_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetProductUseCase mockGetProductUseCase;
  late MockCreateProductUseCase mockCreateProductUseCase;
  late ProductCubit productCubit;

  setUp(() {
    mockGetProductUseCase = MockGetProductUseCase();
    mockCreateProductUseCase = MockCreateProductUseCase();
    productCubit = ProductCubit(
      getProductUseCase: mockGetProductUseCase,
      createProductUseCase: mockCreateProductUseCase,
    );
  });

  const tListProduct = ProductResponseDataModel(
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

  const tProduct = ProductDataModel(
    id: 1,
    name: 'Product 1',
    imageUrl: 'https://via.placeholder.com/100x100',
    desc: 'this is product 1',
  );

  test('initial state should be empty', () {
    expect(productCubit.state, ProductInitial());
  });

  group('Get product cubit', () {
    blocTest<ProductCubit, ProductState>(
      'should emits [ProductLoading, GetProductSuccess] when data is gotten successfully.',
      build: () {
        when(mockGetProductUseCase(NoParams()))
            .thenAnswer((_) async => const Right(tListProduct));

        return productCubit;
      },
      act: (bloc) => bloc.getListProduct(),
      expect: () => <ProductState>[
        ProductLoading(),
        GetProductSuccess(
          bestProducts: tListProduct.bestProducts,
          allProducts: tListProduct.allProducts,
        )
      ],
      verify: (bloc) {
        verify(
          mockGetProductUseCase(NoParams()),
        );
      },
    );

    blocTest<ProductCubit, ProductState>(
      'should emits [ProductLoading, ProductFailure] when data is not success.',
      build: () {
        when(mockGetProductUseCase(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));

        return productCubit;
      },
      act: (bloc) => bloc.getListProduct(),
      expect: () => <ProductState>[
        ProductLoading(),
        const ProductFailure(message: 'Server Failure')
      ],
      verify: (bloc) {
        verify(
          mockGetProductUseCase(NoParams()),
        );
      },
    );
  });

  group('Creat product cubit', () {
    blocTest<ProductCubit, ProductState>(
      'should emits [ProductLoading, CreateProductSuccess] when data is gotten successfully.',
      build: () {
        when(mockCreateProductUseCase(any)).thenAnswer(
          (_) async => const Right(tProduct),
        );

        return productCubit;
      },
      act: (bloc) => bloc.createProduct(
        name: tProduct.name,
        image: File(tProduct.imageUrl),
        desc: tProduct.desc,
      ),
      expect: () => <ProductState>[
        ProductLoading(),
        const CreateProductSuccess(productDataModel: tProduct)
      ],
    );

    blocTest<ProductCubit, ProductState>(
      'should emits [ProductLoading, ProductFailure] when data is not success.',
      build: () {
        when(mockCreateProductUseCase(any)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );

        return productCubit;
      },
      act: (bloc) => bloc.createProduct(
        name: tProduct.name,
        image: File(tProduct.imageUrl),
        desc: tProduct.desc,
      ),
      expect: () => <ProductState>[
        ProductLoading(),
        const ProductFailure(message: 'Server Failure')
      ],
    );
  });
}
