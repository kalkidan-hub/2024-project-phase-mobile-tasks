import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failute.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository _productRepository;

  DeleteProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(int id) {
    return _productRepository.deleteProduct(id);
  }
}
