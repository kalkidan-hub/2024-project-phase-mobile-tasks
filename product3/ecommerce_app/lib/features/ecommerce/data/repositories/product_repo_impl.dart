import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasource/local_datasource.dart';
import '../datasource/remote_datasource.dart';

class ProductRepoImpl implements ProductRepository {
  final ProductRemoteDatasource remoteSource;
  final ProductLocalDatasource localSource;
  final NetworkInfo networkInfo;

  ProductRepoImpl({
    required this.remoteSource,
    required this.localSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> createProduct(Product product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> viewAProduct(int id) {
    // TODO: implement viewAProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> viewAllProduct() {
    // TODO: implement viewAllProduct
    throw UnimplementedError();
  }
}
