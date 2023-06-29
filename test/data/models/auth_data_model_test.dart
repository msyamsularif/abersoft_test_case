import 'dart:convert';

import 'package:abersoft_test_case/data/models/auth_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixture/fixture_render.dart';

void main() {
  const AuthDataModel tAuthDataModel = AuthDataModel(token: '123456');

  const authJson = {"token": "123456", "message": null};
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('auth_model.json'),
      );

      // act
      final result = AuthDataModel.fromJson(jsonMap);

      // assert
      expect(result, tAuthDataModel);
    });
  });

  group('toMap', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tAuthDataModel.toMap();

      // assert
      const expectedMap = authJson;

      expect(result, expectedMap);
    });
  });
}
