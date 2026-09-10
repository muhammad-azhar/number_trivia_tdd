import 'package:equatable/equatable.dart';
import 'package:number_trivia_tdd/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParams extends Equatable{

  @override
  List<Object?> get props => [];
}