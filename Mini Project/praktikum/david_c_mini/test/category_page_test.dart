import 'package:david_c_mini/pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Judul halaman harus Category Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoryPage(),
    ));

    expect(find.text('Category Page'), findsOneWidget);
  });
}