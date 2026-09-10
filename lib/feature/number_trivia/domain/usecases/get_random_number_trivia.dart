import 'package:fpdart/fpdart.dart';
import 'package:number_trivia_tdd/core/errors/failure.dart';
import 'package:number_trivia_tdd/core/usecases/usecase.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {

  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams param) async{
    return await repository.getRandomNumberTrivia();
  }


}