import 'dart:developer';

import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/injection_container.dart' as di;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioLoggingInterceptors extends InterceptorsWrapper {
  final FlutterSecureStorage flutterSecureStorage =
      di.sl<FlutterSecureStorage>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('--> ${options.method.toUpperCase()} ${(options.baseUrl) + (options.path)}');
    log('Headers:');

    options.headers.forEach((k, v) => log('$k: $v'));
    log('queryParameters:');
    options.queryParameters.forEach((k, v) => log('$k: $v'));

    if (options.data != null) {
      log('Body: ${options.data}');
    }
    log('--> END ${options.method.toUpperCase()}');

    if (options.headers.containsKey('requirestoken')) {
      options.headers.remove('requirestoken');

      final accessToken =
          await flutterSecureStorage.read(key: ConstantName.keyToken);

      log('accessToken: $accessToken');

      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('<-- ${response.statusCode} ${(response.requestOptions.baseUrl + response.requestOptions.path)}');
    log('Headers:');
    response.headers.forEach((k, v) => log('$k: $v'));
    log('Response: ${response.data}');
    log('<-- END HTTP');
    super.onResponse(response, handler);
  }
}
