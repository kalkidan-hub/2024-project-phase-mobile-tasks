import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/features/ecommerce/data/models/product_model.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  ProductModel tproductModel = ProductModel(
    id: 1,
    name: 'product',
    price: 100,
    description: 'description',
    imageUrl: 'image',
  );

  test("should be a subclass of Product entity", () async {
    // assert
    expect(tproductModel, isA<Product>());
  });
  test("should return a valid json format", () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_product_response.json'));
    // act
    final result = ProductModel.fromJson(jsonMap);
    // assert
    expect(result, tproductModel);
  });

  test("should convert the product model to json", () async {
    // act
    final result = tproductModel.toJson();
    // assert
    expect(result, {
      'name': 'product',
      'description': 'description',
      'price': 100,
      'imageUrl': 'image',
    });
  });
}
