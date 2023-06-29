import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/repositories/product_repository.dart';

class CreateProductUseCase
    extends UseCase<ProductDataModel, CreateProductParam> {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductDataModel>> call(
      CreateProductParam params) async {
    return await productRepository.createProduct(
      name: params.name,
      image: params.image,
      desc: params.desc,
    );
  }
}

class CreateProductParam extends Equatable {
  final int id;
  final String name;
  final File image;
  final String desc;

  const CreateProductParam({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
  });
  @override
  List<Object?> get props => [id, name, image, desc];
}
