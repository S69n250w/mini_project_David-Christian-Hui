// about_screen_test.dart

import 'package:david_c_mini/pages/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Judul halaman harus About Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: AboutScreen(),
    ));
    
    // Verify that the title text is present
    expect(find.text('About Screen'), findsOneWidget);
  });
}