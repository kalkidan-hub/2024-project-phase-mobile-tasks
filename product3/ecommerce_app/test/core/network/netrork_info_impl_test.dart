import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// import 'package:ecommerce_app/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

// @GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });
  test("should forward the call to InternetConnectionChecker", () {
    final tHasConnectionFuture = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);

    final result = networkInfoImpl.isConnected;

    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
}
