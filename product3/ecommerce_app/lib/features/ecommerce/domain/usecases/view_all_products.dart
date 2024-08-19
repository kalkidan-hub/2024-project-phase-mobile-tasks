import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/product_repository.dart';

class ViewAllProducts {
  final ProductRepository productRepository;
  ViewAllProducts(this.productRepository);
  Future<Either<Failure, Product>> execute() {
    return productRepository.viewAllProduct();
  }
}
