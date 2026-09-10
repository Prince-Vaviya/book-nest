import 'package:flutter_test/flutter_test.dart';
import 'package:booknest/main.dart';

void main() {
  testWidgets('BookNest app smoke test and splash transition', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BookNestApp());

    // Initially on SplashScreen
    expect(find.text('Book'), findsOneWidget);
    expect(find.text('Nest'), findsOneWidget);

    // Fast-forward time past splash delay (2.5s) and transition
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pump(const Duration(milliseconds: 700));

    // Verify MainShell home dashboard is shown
    expect(find.text('Today’s Goal'), findsOneWidget);
  });
}
