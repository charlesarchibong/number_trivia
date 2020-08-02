import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataCOnnectionChecker;
  NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockDataCOnnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataCOnnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      final tConnectionStatusFuture = Future.value(true);
      when(mockDataCOnnectionChecker.hasConnection).thenAnswer(
        (_) => tConnectionStatusFuture,
      );
      final result = networkInfoImpl.isConnected;

      verify(mockDataCOnnectionChecker.hasConnection);
      expect(result, tConnectionStatusFuture);
    });
  });
}
