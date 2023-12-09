import 'package:david_c_mini/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Judul halaman harus Transaction Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TransactionPage(),
    ));

    expect(find.text('Transaction Page'), findsOneWidget);
  });
}