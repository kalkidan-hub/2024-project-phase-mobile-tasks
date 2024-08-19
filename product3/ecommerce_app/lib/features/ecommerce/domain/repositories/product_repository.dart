import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failute.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> viewAllProduct();
  Future<Either<Failure, Product>> viewAProduct(int id);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, Product>> deleteProduct(int id);
}
