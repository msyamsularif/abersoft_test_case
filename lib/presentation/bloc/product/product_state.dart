part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductDataModel> bestProducts;
  final List<ProductDataModel> allProducts;

  const ProductLoaded({
    required this.bestProducts,
    required this.allProducts,
  });

  @override
  List<Object> get props => [bestProducts, allProducts];
}

class ProductFailure extends ProductState {
  final String message;

  const ProductFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
