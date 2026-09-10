import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object?> get props => [];
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent{}