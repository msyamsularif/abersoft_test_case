import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source.dart';
import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);
  @override
  Future<Either<Failure, ProductDataModel>> createProduct({
    required String name,
    required String image,
    required String desc,
  }) async {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductResponseDataModel>> getAllProduct() async {
    try {
      Response response = await dio.post(
        ConstantName.baseUrl + ConstantName.pathUrlProduct,
        options: Options(
          headers: {
            'requirestoken': true,
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        ProductResponseDataModel product =
            ProductResponseDataModel.fromJson(data);

        return right(product);
      } else {
        throw DioException;
      }
    } catch (e) {
      if (e is DioException) {
        // Bad Request: Retrieve error message from response body

        final errorResponse = e.response?.data;
        final errorMessage = errorResponse['message'];

        left(ServerFailure(message: errorMessage));
      }

      return left(ServerFailure(message: 'Failed to fetch data'));
    }
  }
}
