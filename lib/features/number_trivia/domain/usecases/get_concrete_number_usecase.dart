import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> execute({@required number}) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
