import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booknest/main.dart';
import 'package:booknest/screens/admin/admin_shell.dart';
import 'package:booknest/screens/auth/login_screen.dart';
import 'package:booknest/screens/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('Splash transition to LoginScreen and Reader One-Click Flow',
      (WidgetTester tester) async {
    // Build our app and trigger initial frame.
    await tester.pumpWidget(const BookNestApp());

    // Initially on SplashScreen
    expect(find.text('Book'), findsOneWidget);
    expect(find.text('Nest'), findsOneWidget);

    // Fast-forward time past splash delay (2.5s) and transition
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Verify LoginScreen is loaded with Reader and Admin login options
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Sign in to your intellectual sanctuary'), findsOneWidget);
    expect(find.text('SIGN IN AS READER'), findsOneWidget);
    expect(find.text('ADMIN LOGIN'), findsOneWidget);

    // 1-Click Reader Login (no credentials required)
    await tester.tap(find.text('SIGN IN AS READER'));
    await tester.pumpAndSettle();

    // First time user lands on OnboardingScreen
    expect(find.byType(OnboardingScreen), findsOneWidget);

    // Advance to reader details
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Enter Reader Name
    final nameField = find.widgetWithText(TextField, 'Rajneesh');
    await tester.enterText(nameField, 'Aurelius');
    await tester.pumpAndSettle();

    // Advance to reading intentions
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Enter sanctuary
    await tester.tap(find.text('ENTER YOUR SANCTUARY'));
    await tester.pumpAndSettle();

    // Verify user is in MainShell and greeted with custom name
    expect(find.textContaining('Aurelius'), findsOneWidget);
    expect(find.text('Today’s Goal'), findsOneWidget);
  });

  testWidgets('One-Click Admin Login (No credentials required)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BookNestApp());
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Verify on LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);

    // Scroll to & Tap One-Click ADMIN LOGIN button
    final adminBtn = find.text('ADMIN LOGIN');
    await tester.ensureVisible(adminBtn);
    await tester.pumpAndSettle();

    await tester.tap(adminBtn);
    await tester.pumpAndSettle();

    // Verify immediately inside Admin Portal
    expect(find.byType(AdminShell), findsOneWidget);
    expect(find.text('ADMIN PORTAL'), findsOneWidget);
    expect(find.text('Admin Operations'), findsOneWidget);
  });

  testWidgets('Admin Login via Role Switcher Tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BookNestApp());
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Select Admin Login tab
    await tester.tap(find.text('Admin Login'));
    await tester.pumpAndSettle();

    expect(find.text('Chief Archival Curator (Admin)'), findsOneWidget);
    expect(find.text('ONE-CLICK ADMIN LOGIN'), findsOneWidget);

    // Tap ONE-CLICK ADMIN LOGIN
    final adminSubmitBtn = find.text('ONE-CLICK ADMIN LOGIN');
    await tester.ensureVisible(adminSubmitBtn);
    await tester.pumpAndSettle();

    await tester.tap(adminSubmitBtn);
    await tester.pumpAndSettle();

    // Verify in Admin Portal
    expect(find.byType(AdminShell), findsOneWidget);
    expect(find.text('ADMIN PORTAL'), findsOneWidget);
  });

  testWidgets('Admin Portal switch to Reader Sanctuary and Sign Out flow',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BookNestApp());
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Scroll to & Tap 1-Click Admin Login
    final adminBtn = find.text('ADMIN LOGIN');
    await tester.ensureVisible(adminBtn);
    await tester.pumpAndSettle();

    await tester.tap(adminBtn);
    await tester.pumpAndSettle();

    expect(find.byType(AdminShell), findsOneWidget);

    // Switch to Reader Sanctuary from Admin
    await tester.tap(find.text('Reader Sanctuary'));
    await tester.pumpAndSettle();

    // Should arrive in Reader Sanctuary / Onboarding / MainShell
    expect(find.text('BookNest'), findsNothing); // Passed splash

    // Go to Profile tab
    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    // Scroll to find Sign Out tile
    final signOutFinder = find.text('Sign Out / Switch Role');
    await tester.scrollUntilVisible(
      signOutFinder,
      100.0,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // Tap Sign Out
    await tester.tap(signOutFinder);
    await tester.pumpAndSettle();

    // Verify returned to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
