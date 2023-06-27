import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/data/datasource/auth_remote_data_source.dart';
import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, AuthDataModel>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        ConstantName.baseUrl + ConstantName.pathUrlLogin,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final data = response.data;

      AuthDataModel auth = AuthDataModel.fromJson(data);

      if (auth.token != null) {
        return right(auth);
      } else {
        return left(ServerFailure(message: auth.message));
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
