import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:number_trivia_tdd/core/errors/exceptions.dart';
import 'package:number_trivia_tdd/feature/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl({required this.dio});
  final Dio dio;

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    try {
      final response = await dio.get('fact');
      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : Map<String, dynamic>.from(response.data);

        final factText = data['fact'] as String;
        final factLength = (data['length'] ?? 42) as int;

        return NumberTriviaModel(
          text: factText,
          number: factLength,
        );
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
