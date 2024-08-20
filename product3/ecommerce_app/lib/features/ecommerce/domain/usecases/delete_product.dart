import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository _productRepository;

  DeleteProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(String id) {
    return _productRepository.deleteProduct(id);
  }
}
