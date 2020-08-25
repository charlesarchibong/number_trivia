import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart' as ClassMatcher;
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSource;
  MockHttpClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHttpClient();
    numberTriviaRemoteDataSource = NumberTriviaRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });
  void setUpMockHttpClient200() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer((_) async => http.Response(
        json.encode(
          {'text': 'Gotten number', 'number': 1},
        ),
        200));
  }

  void setUpMockHttpFailure404() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getContreteNumberTriva', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      {'text': 'Gotten number', 'number': 1},
    );
    test('''should perform a GET request  on a URL with number 
    being in the endpoint and with application/json header''', () async {
      setUpMockHttpClient200();
      await numberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber);

      verify(
        mockHttpClient.get(
          'http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test('should return numbertrivia model when the status code is 200',
        () async {
      setUpMockHttpClient200();

      final result = await numberTriviaRemoteDataSource.getConcreteNumberTrivia(
        tNumber,
      );

      expect(result, equals(tNumberTriviaModel));
    });
    test('''should return ServerException when 
    the status code of the request is not 200''', () {
      setUpMockHttpFailure404();
      final call = numberTriviaRemoteDataSource.getConcreteNumberTrivia;
      expect(
        () => call(tNumber),
        throwsA(
          ClassMatcher.TypeMatcher<ServerException>(),
        ),
      );
    });
  });

  group('getRandomNumberTriva', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      {'text': 'Gotten number', 'number': 1},
    );
    test('''should perform a GET request  on a URL with number 
    being in the endpoint and with application/json header''', () async {
      setUpMockHttpClient200();
      await numberTriviaRemoteDataSource.getRandomNumberTrivia();

      verify(
        mockHttpClient.get(
          'http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test('should return numbertrivia model when the status code is 200',
        () async {
      setUpMockHttpClient200();

      final result = await numberTriviaRemoteDataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });
    test('''should return ServerException when 
    the status code of the request is not 200''', () {
      setUpMockHttpFailure404();
      final call = numberTriviaRemoteDataSource.getRandomNumberTrivia;
      expect(
        () => call(),
        throwsA(
          ClassMatcher.TypeMatcher<ServerException>(),
        ),
      );
    });
  });
}
