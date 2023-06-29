import 'package:abersoft_test_case/core/domain/usecase/use_case.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:abersoft_test_case/domain/usecase/create_product_use_case.dart';
import 'package:abersoft_test_case/domain/usecase/get_product_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase _getProductUseCase;
  final CreateProductUseCase _createProductUseCase;

  ProductCubit({
    required GetProductUseCase getProductUseCase,
    required CreateProductUseCase createProductUseCase,
  })  : _getProductUseCase = getProductUseCase,
        _createProductUseCase = createProductUseCase,
        super(ProductInitial());

  void getListProduct() async {
    emit(ProductLoading());

    final listProductOrFailure = await _getProductUseCase(NoParams());

    emit(
      listProductOrFailure.fold(
        (l) => ProductFailure(message: l.failureMessage()),
        (r) => ProductLoaded(
          bestProducts: r.bestProducts,
          allProducts: r.allProducts,
        ),
      ),
    );
  }
}
