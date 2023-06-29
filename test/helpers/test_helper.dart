import 'dart:io';

import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source.dart';
import 'package:abersoft_test_case/data/datasource/product/product_remote_data_source.dart';
import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';
import 'package:abersoft_test_case/domain/repositories/product_repository.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:abersoft_test_case/domain/usecase/create_product_use_case.dart';
import 'package:abersoft_test_case/domain/usecase/get_product_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  Dio,
  File,
  AuthRemoteDataSource,
  AuthRepository,
  AuthUseCase,
  ProductRemoteDataSource,
  ProductRepository,
  GetProductUseCase,
  CreateProductUseCase,
  FlutterSecureStorage,
])
void main() {}
