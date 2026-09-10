import 'package:equatable/equatable.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object?> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState{}

class NumberTriviaLoading extends NumberTriviaState{}

class NumberTriviaLoaded extends NumberTriviaState{
  final NumberTrivia numberTrivia;

  const NumberTriviaLoaded({required this.numberTrivia});

  @override
  List<Object?> get props => [numberTrivia];
}

class NumberTriviaError extends NumberTriviaState{
  final String message;

  const NumberTriviaError({required this.message});

  @override
  List<Object?> get props => [message];
}