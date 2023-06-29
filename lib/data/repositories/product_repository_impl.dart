import 'dart:io';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);
  @override
  Future<Either<Failure, ProductDataModel>> createProduct({
    required String name,
    required File image,
    required String desc,
  }) async {
    return productRemoteDataSource.createProduct(
      name: name,
      image: image,
      desc: desc,
    );
  }

  @override
  Future<Either<Failure, ProductResponseDataModel>> getAllProduct() async {
    return productRemoteDataSource.getAllProduct();
  }
}
