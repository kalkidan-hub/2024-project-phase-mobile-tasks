import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
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

  final tProduct = Product(
      id: "1",
      name: "name",
      description: "description",
      price: 10.0,
      imageUrl: "imageUrl");
  final tProductModel = ProductModel.toProduct(tProduct);

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

  test("check connection", () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemoteSource.viewAllProduct())
        .thenAnswer((_) async => await [tProductModel]);
    // act
    print("networkInfo.isConnected: ${await mockNetworkInfo.isConnected}");
    await productRepoImpl.viewAllProduct();
    // assert
    print("networkInfo.isConnected: ${await mockNetworkInfo.isConnected}");
    verify(mockNetworkInfo.isConnected);
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("create product", () {
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.createProduct(tProductModel))
            .thenAnswer((_) async => tProductModel);
        // act
        final result = await productRepoImpl.createProduct(tProduct);
        // assert
        verify(mockRemoteSource.createProduct(tProductModel));
        expect(result, (Right(tProductModel)));
      });

      test(
          "should cache the data locally when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.createProduct(tProductModel))
            .thenAnswer((_) async => tProductModel);
        // act
        await productRepoImpl.createProduct(tProduct);
        // assert
        verify(mockRemoteSource.createProduct(tProductModel));
        verify(mockLocalSource.cacheProduct(tProductModel));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange

        when(mockRemoteSource.createProduct(tProductModel))
            .thenThrow(ServerException());
        // act
        final result = await productRepoImpl.createProduct(tProduct);
        // assert
        verify(mockRemoteSource.createProduct(tProductModel));
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestOffline(() {
      final tProduct = Product(
          id: "1",
          name: "name",
          description: "description",
          price: 10.0,
          imageUrl: "imageUrl");
      // final tProductModel = ProductModel.toProduct(tProduct);
      test("should return server failure when the device is offline", () async {
        // act
        final result = await productRepoImpl.createProduct(tProduct);
        // assert
        // verifyZeroInteractions(mockRemoteSource);
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(NetworkFailure()));
      });
    });
  });
  group("delete product", () {
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.deleteProduct("1"))
            .thenAnswer((_) async => tProductModel);
        // act
        final result = await productRepoImpl.deleteProduct("1");
        // assert
        verify(mockRemoteSource.deleteProduct("1"));
        expect(result, (Right(tProductModel)));
      });

      test(
          "should cache the data locally when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.deleteProduct("1"))
            .thenAnswer((_) async => tProductModel);
        // act
        await productRepoImpl.deleteProduct("1");
        // assert
        verify(mockRemoteSource.deleteProduct("1"));
        verify(mockLocalSource.deleteProduct("1"));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange

        when(mockRemoteSource.deleteProduct("1")).thenThrow(ServerException());
        // act
        final result = await productRepoImpl.deleteProduct("1");
        // assert
        verify(mockRemoteSource.deleteProduct("1"));
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(ServerFailure()));
      });
    });
    runTestOffline(() {
      test("should return server failure when the device is offline", () async {
        // act
        final result = await productRepoImpl.deleteProduct("1");
        // assert
        // verifyZeroInteractions(mockRemoteSource);
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(NetworkFailure()));
      });
    });
  });

  group("view a product", () {
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.viewAProduct("1"))
            .thenAnswer((_) async => tProductModel);
        // act
        final result = await productRepoImpl.viewAProduct("1");
        // assert
        verify(mockRemoteSource.viewAProduct("1"));
        expect(result, (Right(tProductModel)));
      });

      test(
          "should cache the data locally when the call to remote data source is successful",
          () async {
        // arrange

        when(mockRemoteSource.viewAProduct("1"))
            .thenAnswer((_) async => tProductModel);
        // act
        await productRepoImpl.viewAProduct("1");
        // assert
        verify(mockRemoteSource.viewAProduct("1"));
        verify(mockLocalSource.cacheProduct(tProductModel));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange

        when(mockRemoteSource.viewAProduct("1")).thenThrow(ServerException());
        // act
        final result = await productRepoImpl.viewAProduct("1");
        // assert
        verify(mockRemoteSource.viewAProduct("1"));
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(ServerFailure()));
      });
    });
    runTestOffline(() {
      test("should return server failure when the device is offline", () async {
        // act
        final result = await productRepoImpl.viewAProduct("1");
        // assert
        // verifyZeroInteractions(mockRemoteSource);
        verifyZeroInteractions(mockLocalSource);
        expect(result, Left(NetworkFailure()));
      });
    });

    group("view all product", () {
      runTestOnline(() {
        test(
            "should return remote data when the call to remote data source is successful",
            () async {
          // arrange

          when(mockRemoteSource.viewAllProduct())
              .thenAnswer((_) async => await [tProductModel]);
          // act
          final result = await productRepoImpl.viewAllProduct();
          // assert
          verify(mockRemoteSource.viewAllProduct());
          expect(result, (Right([tProductModel])));
        });

        test(
            "should cache the data locally when the call to remote data source is successful",
            () async {
          // arrange

          when(mockRemoteSource.viewAllProduct())
              .thenAnswer((_) async => await [tProductModel]);
          // act
          await productRepoImpl.viewAllProduct();
          // assert
          verify(mockRemoteSource.viewAllProduct());
          // verify(mockLocalSource.cacheProductList([tProductModel]));
        });

        test(
            "should return server failure when the call to remote data source is unsuccessful",
            () async {
          // arrange

          when(mockRemoteSource.viewAllProduct()).thenThrow(ServerException());
          // act
          final result = await productRepoImpl.viewAllProduct();
          // assert
          verify(mockRemoteSource.viewAllProduct());
          verifyZeroInteractions(mockLocalSource);
          expect(result, Left(ServerFailure()));
        });
      });
    });
  });
}
