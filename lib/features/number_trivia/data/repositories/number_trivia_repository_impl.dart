import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';

typedef Future<NumberTrivia> _GetRandomOrConcreteNumber();

class NumberTriviaRepostoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepostoryImpl({
    @required this.numberTriviaLocalDataSource,
    @required this.numberTriviaRemoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getNumberTrivia(
      () => numberTriviaRemoteDataSource.getConcreteNumberTrivia(
        number,
      ),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getNumberTrivia(
      () => numberTriviaRemoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
      _GetRandomOrConcreteNumber getRandomOrConcreteNumber) async {
    try {
      if (await networkInfo.isConnected) {
        final numberTrivia = await getRandomOrConcreteNumber();

        await numberTriviaLocalDataSource.cacheNumberTrivia(numberTrivia);
        return Right(numberTrivia);
      } else {
        final localNumberTrivia =
            await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(localNumberTrivia);
      }
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
