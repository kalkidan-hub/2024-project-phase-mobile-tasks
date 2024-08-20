import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/product_repository.dart';

class ViewAProduct {
  final ProductRepository _productRepository;

  ViewAProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(String id) {
    return _productRepository.viewAProduct(id);
  }
}
