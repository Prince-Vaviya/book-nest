import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booknest/main.dart';
import 'package:booknest/screens/admin/admin_shell.dart';

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

  testWidgets('Admin portal smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BookNestApp());
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pump(const Duration(milliseconds: 700));

    // Switch to Profile Tab
    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    // Scroll down to find Admin Portal tile
    final adminTileFinder = find.text('Admin Operations Portal');
    await tester.scrollUntilVisible(
      adminTileFinder,
      100.0,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // Verify Admin Portal tile is present
    expect(adminTileFinder, findsOneWidget);

    // Tap to enter Admin Portal
    await tester.tap(adminTileFinder);
    await tester.pumpAndSettle();

    // Verify we are inside the Admin Portal
    expect(find.byType(AdminShell), findsOneWidget);
    expect(find.text('ADMIN PORTAL'), findsOneWidget);
    expect(find.text('Admin Operations'), findsOneWidget);
  });
}
