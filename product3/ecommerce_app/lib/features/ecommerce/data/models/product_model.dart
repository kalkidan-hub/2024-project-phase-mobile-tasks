import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) : super(
            id: id,
            name: name,
            description: description,
            price: price,
            imageUrl: imageUrl);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.toProduct(Product product) {
    return ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
  }
}
