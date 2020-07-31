import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(
      number: 1, text: '1 is the number that spells  in leetspeak.');
  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid object when the JSON number is integer',
        () async {
      Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      print(jsonMap.toString());
      expect(result, tNumberTriviaModel);
    });
    test(
        'should return a valid object when the JSON number is regarded as double',
        () async {
      Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      print(jsonMap.toString());
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a json object of numbertrivia model', () async {
      final result = tNumberTriviaModel.toJson();
      expect(result,
          {"text": "1 is the number that spells  in leetspeak.", "number": 1});
    });
  });
}
