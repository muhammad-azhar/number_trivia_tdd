import 'package:fpdart/fpdart.dart';
import 'package:number_trivia_tdd/core/errors/exceptions.dart';
import 'package:number_trivia_tdd/core/errors/failure.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {

  const NumberTriviaRepositoryImpl({required this.remoteDataSource});
  final NumberTriviaRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
    try{
      final remoteTriviaModel = await remoteDataSource.getRandomNumberTrivia();
      return Right(remoteTriviaModel);
    } on ServerException{
      return const Left(ServerFailure());
    }
  }

}