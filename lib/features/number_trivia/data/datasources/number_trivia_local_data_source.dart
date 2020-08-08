import 'dart:convert';

import 'package:number_trivia/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<bool> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(numberTriviaModel.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null)
      return NumberTriviaModel.fromJson(
        json.decode(
          jsonString,
        ),
      );
    else
      throw CacheException();
  }
}
