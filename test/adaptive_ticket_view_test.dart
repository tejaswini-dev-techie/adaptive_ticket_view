import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_ticket_view/adaptive_ticket_view.dart';

void main() {
  testWidgets('AdaptiveTicketView renders correctly',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdaptiveTicketView(
            ticketBgColor: Colors.blue[100]!,
            ticketBorderColor: Colors.blue,
            ticketInfoWidget: const Text('Test Content'),
            ticketBottomMessage: 'Test Message',
            ticketCode: 'TEST123',
            lineStyle: TicketLineStyle.dotted,
          ),
        ),
      ),
    );

    // Verify that the widget renders without errors
    expect(find.byType(AdaptiveTicketView), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);
    expect(find.text('TEST123'), findsOneWidget);
  });

  testWidgets('AdaptiveTicketView handles null optional parameters',
      (WidgetTester tester) async {
    // Build our widget with minimal required parameters
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdaptiveTicketView(
            ticketBgColor: Colors.blue[100]!,
            ticketBorderColor: Colors.blue,
          ),
        ),
      ),
    );

    // Verify that the widget renders without errors
    expect(find.byType(AdaptiveTicketView), findsOneWidget);
  });

  testWidgets('AdaptiveTicketView respects showFooter parameter',
      (WidgetTester tester) async {
    // Build our widget with showFooter set to false
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdaptiveTicketView(
            ticketBgColor: Colors.blue[100]!,
            ticketBorderColor: Colors.blue,
            ticketBottomMessage: 'Test Message',
            ticketCode: 'TEST123',
            lineStyle: TicketLineStyle.none,
          ),
        ),
      ),
    );

    // Verify that footer content is not shown
    expect(find.text('Test Message'), findsNothing);
    expect(find.text('TEST123'), findsNothing);
  });
}
