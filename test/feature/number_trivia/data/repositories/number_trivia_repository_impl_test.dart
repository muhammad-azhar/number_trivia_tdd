import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_tdd/core/errors/exceptions.dart';
import 'package:number_trivia_tdd/core/errors/failure.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource{}

void main(){

  late NumberTriviaRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    repository = NumberTriviaRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tNumberTriviaModel = NumberTriviaModel(text: 'Test Trivia', number: 1);
  final NumberTrivia tNumberTrivia = (tNumberTriviaModel as NumberTrivia);

  group('getRandomNumberTrivia', (){
    test('should return remote data when the call to remote data source is successful', () async{
      when(() =>  mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      
      final result = await repository.getRandomNumberTrivia();
      
      verify(() => mockRemoteDataSource.getRandomNumberTrivia()).called(1);
      expect(result, Right(tNumberTrivia));
    });
    
    test('should return ServerFailure when the call to remote data is unsuccessful', () async{
      when(() => mockRemoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());

      final result = await repository.getRandomNumberTrivia();

      verify(() => mockRemoteDataSource.getRandomNumberTrivia()).called(1);
      expect(result, equals(const Left(ServerFailure())));
    });
    
  });
}