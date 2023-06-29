import 'package:equatable/equatable.dart';

import 'package:abersoft_test_case/data/models/product_data_model.dart';

class ProductEntitie extends Equatable {
  final ProductResponseDataModel productResponseDataModel;

  const ProductEntitie({
    required this.productResponseDataModel,
  });
  @override
  List<Object?> get props => [productResponseDataModel];
  
}
