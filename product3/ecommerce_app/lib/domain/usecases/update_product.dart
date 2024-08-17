import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failute.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository _productRepository;

  UpdateProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(Product product) {
    return _productRepository.updateProduct(product);
  }
}
