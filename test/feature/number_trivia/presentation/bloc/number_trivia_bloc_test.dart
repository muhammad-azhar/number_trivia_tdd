import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_tdd/core/errors/failure.dart';
import 'package:number_trivia_tdd/core/usecases/usecase.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_state.dart';

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia{}

void main(){
  late NumberTriviaBloc bloc;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;

  setUp((){
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    bloc = NumberTriviaBloc(getRandomNumberTrivia: mockGetRandomNumberTrivia);
  });
  
  setUpAll(() => registerFallbackValue(NoParams()));
  
  const tNumberTrivia = NumberTrivia(text: 'Test Trivia', number: 1);
  
  test('initial state should return NumberTriviaInitial', (){
    expect(bloc.state, NumberTriviaInitial());
  });

  group('GetNumberTriviaEvent', (){
      blocTest<NumberTriviaBloc, NumberTriviaState>('should emit [NumberTriviaLoading, NumberTriviaLoaded] when data is gotten successful', build: (){
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        return bloc;
      },
        act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
          expect: () => [
            NumberTriviaLoading(),
            NumberTriviaLoaded(numberTrivia: tNumberTrivia)
          ],
      verify: (_){
        verify(() => mockGetRandomNumberTrivia(NoParams())).called(1);
      }
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>('should emit [NumberTriviaLoading, NumberTriviaError] when getting data fails', build: (){
        when(() => mockGetRandomNumberTrivia(any()))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
          act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
          expect: () => [
            NumberTriviaLoading(),
            NumberTriviaError(message: "Server Failure")
          ],
          verify: (_){
            verify(() => mockGetRandomNumberTrivia(NoParams())).called(1);
          }
      );
  });
}