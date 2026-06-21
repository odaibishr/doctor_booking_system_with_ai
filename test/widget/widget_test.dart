import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';

void main() {
  testWidgets('CustomLoader builds and shows loading text', (WidgetTester tester) async {
    // Build the CustomLoader widget in a test environment wrapped in a MaterialApp/Scaffold
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomLoader(loaderSize: 50.0),
        ),
      ),
    );

    // Verify if the loader size or loading text is present
    expect(find.text('جاري التحميل...'), findsOneWidget);
  });
}
