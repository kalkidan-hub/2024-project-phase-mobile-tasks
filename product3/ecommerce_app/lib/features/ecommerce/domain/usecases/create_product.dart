import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failute.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository _productRepository;

  CreateProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(Product product) {
    return _productRepository.createProduct(product);
  }
}
