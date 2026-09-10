import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/pages/number_trivia_page.dart';

import 'injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependencies
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<NumberTriviaBloc>(create: (context) => sl<NumberTriviaBloc>())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDD Trivia',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const NumberTriviaPage(),
    );
  }
}
