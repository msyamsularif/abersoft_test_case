import 'dart:io';

import 'package:abersoft_test_case/data/datasource/auth/auth_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  Dio,
  File,
  AuthRemoteDataSource,
])
void main() {}
