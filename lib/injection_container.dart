import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';

// Global Service Locator instance
final sl = GetIt.instance;

Future<void> init() async {
  //! 1. Features - Number Trivia (Presentation)
  // Factory: Creates a NEW instance every time it's requested (vital for BLoCs/Controllers)
  sl.registerFactory(
        () => NumberTriviaBloc(getRandomNumberTrivia: sl()),
  );

  //! 2. Domain Layer (Use Cases)
  // LazySingleton: Created ONCE when first requested
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //! 3. Data Layer (Repository & Data Sources)
  sl.registerLazySingleton<NumberTriviaRepository>(
        () => NumberTriviaRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(dio: sl()),
  );

  //! 4. External Dependencies
  // sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<Dio>(() => DioClient.createDio());
}