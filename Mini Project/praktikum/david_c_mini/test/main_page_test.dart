import 'package:david_c_mini/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Judul halaman harus Main Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MainPage(),
    ));

    expect(find.text('Main Page'), findsOneWidget);
  });
}