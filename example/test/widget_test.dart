// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_ticket_view_example/main.dart';
import 'package:adaptive_ticket_view/adaptive_ticket_view.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the app renders without errors
    expect(find.byType(AdaptiveTicketView), findsOneWidget);
    expect(find.text('Wings of Wanderlust: Your Ticket to Adventure'),
        findsOneWidget);
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('London'), findsOneWidget);
  });
}
