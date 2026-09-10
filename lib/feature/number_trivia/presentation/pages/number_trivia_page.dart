import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_event.dart';

import '../bloc/number_trivia_state.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Trivia Page'), centerTitle: true, backgroundColor: Colors.lightGreen,),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaInitial) {
                    return const Text('Press button to fetch trivia');
                  } else if (state is NumberTriviaLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is NumberTriviaLoaded) {
                    return Text(
                      state.numberTrivia.text,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    );
                  } else if (state is NumberTriviaError) {
                    return Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  key: const Key('fetch_trivia_button'),
                  onPressed: () {
                    context.read<NumberTriviaBloc>().add(GetRandomNumberTriviaEvent());
                  }, child: const Text('Get Trivia')),
            ],
          ),
        ),
      ),
    );
  }
}
