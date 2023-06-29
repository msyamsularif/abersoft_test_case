import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductUseCase extends UseCase<ProductResponseDataModel, NoParams> {
  final ProductRepository productRepository;

  GetProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductResponseDataModel>> call(
    NoParams params,
  ) async {
    return await productRepository.getAllProduct();
  }
}
