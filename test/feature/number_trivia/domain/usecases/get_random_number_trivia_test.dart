import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:number_trivia_tdd/core/usecases/usecase.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}

void main(){

  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockRepository;

  setUp((){
    mockRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRepository);
  });

  const tNumberTrivia = NumberTrivia(text: 'Test Trivia', number: 1);
  
  test('should get trivia from the repository', () async{

    //ARRANGE
    when(() => mockRepository.getRandomNumberTrivia())
    .thenAnswer((_) async => const Right(tNumberTrivia));

    //ACT
    final result = await usecase(NoParams());

    //ASSERT
    expect(result, const Right(tNumberTrivia));
    verify(() => mockRepository.getRandomNumberTrivia()).called(1);
    verifyNoMoreInteractions(mockRepository);

  });
}