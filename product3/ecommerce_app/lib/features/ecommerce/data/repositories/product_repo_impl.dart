import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasource/local_datasource.dart';
import '../datasource/remote_datasource.dart';
import '../models/product_model.dart';

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
  Future<Either<Failure, Product>> createProduct(Product product) async {
    // TODO: implement createProduct
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteSource.createProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteSource.deleteProduct(id);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = remoteSource.updateProduct(product);
        localSource.cacheProduct(Right(remoteProduct) as ProductModel);
        return Right(await remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> viewAProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteSource.viewAProduct(id);
        localSource.cacheProduct(Right(remoteProduct) as ProductModel);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> viewAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteSource.viewAllProduct();
        localSource.cacheProducts(Right(remoteProduct) as List<ProductModel>);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await localSource.getProducts();
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
