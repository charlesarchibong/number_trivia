import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepostoryImpl numberTriviaRepostoryImpl;
  MockNetworkInfo networkInfo;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    numberTriviaRepostoryImpl = NumberTriviaRepostoryImpl(
      networkInfo: networkInfo,
      numberTriviaLocalDataSource: mockLocalDataSource,
      numberTriviaRemoteDataSource: mockRemoteDataSource,
    );
  });
}
