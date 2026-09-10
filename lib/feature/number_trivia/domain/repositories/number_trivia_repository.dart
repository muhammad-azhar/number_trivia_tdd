import 'package:fpdart/fpdart.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import '../../../../core/errors/failure.dart';

abstract class NumberTriviaRepository {

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}