import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_tdd/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:number_trivia_tdd/feature/number_trivia/presentation/pages/number_trivia_page.dart';

class MockNumberTriviaBloc
    extends MockBloc<NumberTriviaEvent, NumberTriviaState>
    implements NumberTriviaBloc {}

void main() {
  late MockNumberTriviaBloc mockNumberTriviaBloc;

  setUp(() {
    mockNumberTriviaBloc = MockNumberTriviaBloc();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<NumberTriviaBloc>.value(
        value: mockNumberTriviaBloc,
        child: child,
      ),
    );
  }

  const tNumberTrivia = NumberTrivia(text: '42 is the answer to life.', number: 42);

  testWidgets('return initial text when state is NumberTriviaInitial', (tester) async {

    when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaInitial());

    await tester.pumpWidget(makeTestableWidget(const NumberTriviaPage()));

    expect(find.text('Press button to fetch trivia'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('return CircularProgressIndicator when state is NumberTriviaLoading', (tester) async {

    when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaLoading());

    await tester.pumpWidget(makeTestableWidget(const NumberTriviaPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('return trivia text when state is NumberTriviaLoaded', (tester) async {

    when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaLoaded(numberTrivia: tNumberTrivia));

    await tester.pumpWidget(makeTestableWidget(const NumberTriviaPage()));

    expect(find.text('42 is the answer to life.'), findsOneWidget);
  });

  testWidgets('triggers GetRandomNumberTriviaEvent on button tap', (tester) async {
    // ARRANGE
    when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaInitial());

    await tester.pumpWidget(makeTestableWidget(const NumberTriviaPage()));

    // ACT: Tap the button
    final buttonFinder = find.byKey(const Key('fetch_trivia_button'));
    await tester.tap(buttonFinder);
    await tester.pump(); // Triggers a frame rebuild

    // ASSERT: Verify event was added to BLoC
    verify(() => mockNumberTriviaBloc.add(GetRandomNumberTriviaEvent())).called(1);
  });
}
