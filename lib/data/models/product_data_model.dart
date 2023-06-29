import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductDataModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String desc;

  const ProductDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.desc,
  });
  @override
  List<Object> get props => [id, name, imageUrl, desc];

  ProductDataModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? desc,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'productDescription': desc,
    };
  }

  factory ProductDataModel.fromJson(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      desc: map['productDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}

class ProductResponseDataModel extends Equatable {
  final List<ProductDataModel> bestProducts;
  final List<ProductDataModel> allProducts;

  const ProductResponseDataModel({
    required this.bestProducts,
    required this.allProducts,
  });

  @override
  List<Object> get props => [bestProducts, allProducts];

  ProductResponseDataModel copyWith({
    List<ProductDataModel>? bestProducts,
    List<ProductDataModel>? allProducts,
  }) {
    return ProductResponseDataModel(
      bestProducts: bestProducts ?? this.bestProducts,
      allProducts: allProducts ?? this.allProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bestProduct': bestProducts.map((x) => x.toMap()).toList(),
      'allProduct': allProducts.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductResponseDataModel.fromJson(Map<String, dynamic> map) {
    return ProductResponseDataModel(
      bestProducts: List<ProductDataModel>.from(map['bestProduct']?.map((x) => ProductDataModel.fromJson(x))),
      allProducts: List<ProductDataModel>.from(map['allProduct']?.map((x) => ProductDataModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
