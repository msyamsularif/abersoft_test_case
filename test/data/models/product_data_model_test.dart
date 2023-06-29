import 'dart:convert';

import 'package:abersoft_test_case/data/models/product_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixture/fixture_render.dart';

void main() {
  const ProductDataModel tProductDataModel = ProductDataModel(
    id: 1,
    name: 'Product 1',
    imageUrl: 'https://via.placeholder.com/100x100',
    desc: 'this is product 1',
  );

  const productJson = {
    "id": 1,
    "name": "Product 1",
    "imageUrl": "https://via.placeholder.com/100x100",
    "productDescription": "this is product 1"
  };

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('product_response.json'),
      );

      // act
      final result = ProductDataModel.fromJson(jsonMap);

      // assert
      expect(result, tProductDataModel);
    });
  });

  group('toMap', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tProductDataModel.toMap();

      // assert
      const expectedMap = productJson;

      expect(result, expectedMap);
    });
  });
}
