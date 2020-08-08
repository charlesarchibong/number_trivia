import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as ClassMatcher;
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  MockSharedPreferences mockSharedPreferences;
  NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(
      mockSharedPreferences,
    );
  });

  group('setDataToSharedPreferences', () {
    test(
        'should return true when the set cache is call in the local data source',
        () async {
      final NumberTriviaModel numberTriviaModel = NumberTriviaModel(
        text: 'test',
        number: 1,
      );
      Map numberTriviaModelJson = numberTriviaModel.toJson();

      when(
        mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA,
          json.encode(numberTriviaModelJson),
        ),
      ).thenAnswer((_) async => true);
      final result = await numberTriviaLocalDataSourceImpl.cacheNumberTrivia(
        numberTriviaModel,
      );

      verify(
        mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA,
          json.encode(numberTriviaModelJson),
        ),
      );
      expect(result, true);
    });
  });

  group('getDataToSharedPreferences', () {
    final NumberTriviaModel numberTriviaModel = NumberTriviaModel(
      text: 'test',
      number: 1,
    );

    Map numberTriviaModelJson = numberTriviaModel.toJson();
    test(
        'should return number trivia model from the local data source when the getLastNumerTrivia is called',
        () async {
      when(
        mockSharedPreferences.getString(
          CACHED_NUMBER_TRIVIA,
        ),
      ).thenReturn(
        json.encode(numberTriviaModelJson),
      );

      final result =
          await numberTriviaLocalDataSourceImpl.getLastNumberTrivia();

      verify(
        mockSharedPreferences.getString(
          CACHED_NUMBER_TRIVIA,
        ),
      );

      expect(result, numberTriviaModel);
    });

    test(
        'should throw CacheException when the getLastNumerTrivia is called and no data exist in the local storage',
        () async {
      when(
        mockSharedPreferences.getString(
          CACHED_NUMBER_TRIVIA,
        ),
      ).thenReturn(null);

      final call = numberTriviaLocalDataSourceImpl.getLastNumberTrivia;

      expect(
        () => call(),
        throwsA(
          ClassMatcher.TypeMatcher<CacheException>(),
        ),
      );
    });
  });
}
