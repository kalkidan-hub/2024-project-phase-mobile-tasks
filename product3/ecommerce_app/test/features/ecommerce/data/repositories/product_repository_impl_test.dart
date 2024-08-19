import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/ecommerce/data/datasource/local_datasource.dart';
import 'package:ecommerce_app/features/ecommerce/data/datasource/remote_datasource.dart';
import 'package:ecommerce_app/features/ecommerce/data/models/product_model.dart';
import 'package:ecommerce_app/features/ecommerce/data/repositories/product_repo_impl.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDatasource, ProductLocalDatasource, NetworkInfo])
void main() {
  late ProductRepoImpl productRepoImpl;
  late MockProductRemoteDatasource mockRemoteSource;
  late MockProductLocalDatasource mockLocalSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteSource = MockProductRemoteDatasource();
    mockLocalSource = MockProductLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    productRepoImpl = ProductRepoImpl(
      remoteSource: mockRemoteSource,
      localSource: mockLocalSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final ProductModel tProductModel = ProductModel(
    id: 1,
    name: "product",
    price: 100,
    description: "description",
    imageUrl: "",
  );
  final Product tProduct = tProductModel;

  group("createProduct", () {
    test(
        "should return product when the call to remote data source is successful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.createProduct(any))
          .thenAnswer((_) async => tProductModel);

      final result = await productRepoImpl.createProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.createProduct(tProduct));
      expect(result, equals(Right(tProduct)));
    });

    test(
        "should return server failure when the call to remote data source is unsuccessful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.createProduct(any)).thenThrow(ServerException());

      final result = await productRepoImpl.createProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.createProduct(tProduct));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("deleteProduct", () {
    test(
        "should return product when the call to remote data source is successful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.deleteProduct(any))
          .thenAnswer((_) async => tProductModel);

      final result = await productRepoImpl.deleteProduct(tProduct.id);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.deleteProduct(tProduct.id));
      expect(result, equals(Right(tProduct)));
    });

    test(
        "should return server failure when the call to remote data source is unsuccessful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.deleteProduct(any)).thenThrow(ServerException());

      final result = await productRepoImpl.deleteProduct(tProduct.id);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.deleteProduct(tProduct.id));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("updateProduct", () {
    test(
        "should return product when the call to remote data source is successful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.updateProduct(any))
          .thenAnswer((_) async => tProductModel);

      final result = await productRepoImpl.updateProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.updateProduct(tProduct));
      verify(mockLocalSource.cacheProduct(tProductModel));
      expect(result, equals(Right(tProduct)));
    });

    test(
        "should return server failure when the call to remote data source is unsuccessful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.updateProduct(any)).thenThrow(ServerException());

      final result = await productRepoImpl.updateProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.updateProduct(tProduct));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("viewAProduct", () {
    test(
        "should return product when the call to remote data source is successful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.viewAProduct(any))
          .thenAnswer((_) async => tProductModel);

      final result = await productRepoImpl.viewAProduct(tProduct.id);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.viewAProduct(tProduct.id));
      verify(mockLocalSource.cacheProduct(tProductModel));
      expect(result, equals(Right(tProduct)));
    });

    test(
        "should return server failure when the call to remote data source is unsuccessful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.viewAProduct(any)).thenThrow(ServerException());

      final result = await productRepoImpl.viewAProduct(tProduct.id);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.viewAProduct(tProduct.id));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("viewAllProduct", () {
    test(
        "should return products when the call to remote data source is successful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.viewAllProduct())
          .thenAnswer((_) async => [tProductModel]);

      final result = await productRepoImpl.viewAllProduct();

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.viewAllProduct());
      verify(mockLocalSource.cacheProducts([tProductModel]));
      expect(result, equals(Right([tProductModel])));
    });

    test(
        "should return server failure when the call to remote data source is unsuccessful",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteSource.viewAllProduct()).thenThrow(ServerException());

      final result = await productRepoImpl.viewAllProduct();

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteSource.viewAllProduct());
      expect(result, equals(Left(ServerFailure())));
    });

    test("should return cached data when there is no internet connection",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalSource.getProducts())
          .thenAnswer((_) async => [tProductModel]);

      final result = await productRepoImpl.viewAllProduct();

      verifyZeroInteractions(mockRemoteSource);
      verify(mockLocalSource.getProducts());
      expect(result, equals(Right([tProductModel])));
    });

    test(
        "should return cache failure when there is no internet connection and no cached data",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalSource.getProducts()).thenThrow(CacheException());

      final result = await productRepoImpl.viewAllProduct();

      verifyZeroInteractions(mockRemoteSource);
      verify(mockLocalSource.getProducts());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
