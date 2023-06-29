import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, ProductResponseDataModel>> getAllProduct();

  Future<Either<Failure, ProductDataModel>> createProduct({
    required String name,
    required String image,
    required String desc,
  });
}
