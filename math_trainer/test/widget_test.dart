// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:math_trainer/main.dart';
import 'package:math_trainer/game_state.dart';

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => GameState(),
        child: const MathTrainerApp(),
      ),
    );

    // Verify that the app title is shown.
    expect(find.text('Math Trainer'), findsWidgets);

    // Verify that the menu buttons are present.
    expect(find.text('START GAME'), findsOneWidget);
    expect(find.text('TAKE ASSESSMENT'), findsOneWidget);
  });
}
