import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_tdd/core/usecases/usecase.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia getRandomNumberTrivia;
  NumberTriviaBloc({required this.getRandomNumberTrivia})
    : super(NumberTriviaInitial()) {
    on<GetRandomNumberTriviaEvent>(_onGetRandomNumberTriviaEvent);
  }

  FutureOr<void> _onGetRandomNumberTriviaEvent(
    GetRandomNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoading());

    final failureOrTrivia = await getRandomNumberTrivia(NoParams());

    failureOrTrivia.fold(
      (failure) => emit(NumberTriviaError(message: failure.message)),
      (trivia) => emit(NumberTriviaLoaded(numberTrivia: trivia)),
    );
  }
}
