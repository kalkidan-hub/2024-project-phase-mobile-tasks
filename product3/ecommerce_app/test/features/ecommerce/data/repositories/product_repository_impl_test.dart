import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/ecommerce/data/datasource/local_datasource.dart';
import 'package:ecommerce_app/features/ecommerce/data/datasource/remote_datasource.dart';
import 'package:ecommerce_app/features/ecommerce/data/repositories/product_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteSource extends Mock implements ProductRemoteDatasource {}

class MockLocalSource extends Mock implements ProductLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ProductRepoImpl productRepoImpl;
  MockRemoteSource mockRemoteSource;
  MockLocalSource mockLocalSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteSource = MockRemoteSource();
    mockLocalSource = MockLocalSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepoImpl = ProductRepoImpl(
      remoteSource: mockRemoteSource,
      localSource: mockLocalSource,
      networkInfo: mockNetworkInfo,
    );
  });
  test("", () {});
}
