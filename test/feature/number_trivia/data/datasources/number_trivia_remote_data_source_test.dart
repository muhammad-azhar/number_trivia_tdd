import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_tdd/core/errors/exceptions.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/models/number_trivia_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late NumberTriviaRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = NumberTriviaRemoteDataSourceImpl(dio: mockDio);
  });

  const tNumberTriviaModel = NumberTriviaModel(text: 'Test Trivia', number: 1);
  final tMap = {'text': 'Test Trivia', 'number': 1};

  group('getRandomNumberTrivia', () {
    test('should perform a GET request on a URL and return NumberTriviaModel when response', () async {
      //arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: tMap,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      //act
      final result = await dataSource.getRandomNumberTrivia();

      //assert
      verify(() => mockDio.get('random/trivia?json'))
          .called(1);
      expect(result, equals(tNumberTriviaModel));
    });

    test(
      'should throw ServerException when the response code is 404 or other',
      () {
        // ARRANGE
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
        );
        // ACT
        final call = dataSource.getRandomNumberTrivia;

        // ASSERT
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
