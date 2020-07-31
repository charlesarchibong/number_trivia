import 'package:meta/meta.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, int number})
      : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> map) {
    return NumberTriviaModel(
      text: map['text'],
      number: (map['number'] as num).toInt(),
    );
  }
}
