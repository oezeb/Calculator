// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/main.dart';

findButton(String str) {
  var btn = find.widgetWithText(ElevatedButton, str);
  expect(btn, findsOneWidget);
  print('Button $str found');
  return btn;
}

void main() {
  testWidgets('Calculator test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // find screen buttons
    var zero = findButton('0');
    var one = findButton('1');
    var two = findButton('2');
    var three = findButton('3');
    var four = findButton('4');
    var five = findButton('5');
    var six = findButton('6');
    var seven = findButton('7');
    var eight = findButton('8');
    var nine = findButton('9');

    var mc = findButton('mc');
    var mPlus = findButton('m+');
    var mSub = findButton('m−');
    var mr = findButton('mr');

    var clear = findButton('C');

    var dot = findButton('.');
    var percent = findButton('%');

    var mul = findButton('×');
    var div = findButton('÷');
    var add = findButton('+');
    var sub = findButton('−');

    var equal = findButton('=');

    var del = find.byIcon(Icons.backspace_outlined);
    expect(del, findsOneWidget);
    print('Button delete found');

    // 1+2*3 == 7
    print('start testing 1+2*3 == 7');
    await tester.tap(one);
    await tester.pump();
    print('tap 1');
    await tester.tap(add);
    await tester.pump();
    print('tap +');
    await tester.tap(two);
    await tester.pump();
    print('tap 2');
    await tester.tap(mul);
    await tester.pump();
    print('tap *');
    await tester.tap(three);
    await tester.pump();
    print('tap 3');

    print('checking result');
    expect(find.widgetWithText(TextField, '7'), findsOneWidget);
    print('test 1+2*3 == 7 succeed');

    await tester.tap(clear);
    await tester.pump();
    print('tap clear');

    // 1÷5% == 20
    print('start checking 1÷5% == 20.0');
    await tester.tap(one);
    await tester.pump();
    print('tap 1');
    await tester.tap(div);
    await tester.pump();
    print('tap ÷');
    await tester.tap(five);
    await tester.pump();
    print('tap 5');
    await tester.tap(percent);
    await tester.pump();
    print('tap %');

    print('checking result');
    expect(find.widgetWithText(TextField, '20.0'), findsOneWidget);
    print('test 1÷5% == 20 succeed');

    await tester.tap(clear);
    await tester.pump();
    print('tap clear');

    // 1+2*31÷-5%
    print('start testing 1+2*31÷−5% = −1239.0');
    await tester.tap(one);
    await tester.pump();
    print('tap 1');
    await tester.tap(add);
    await tester.pump();
    print('tap +');
    await tester.tap(two);
    await tester.pump();
    print('tap 2');
    await tester.tap(mul);
    await tester.pump();
    print('tap *');
    await tester.tap(three);
    await tester.pump();
    print('tap 3');
    await tester.tap(one);
    await tester.pump();
    print('tap 1');
    await tester.tap(div);
    await tester.pump();
    print('tap ÷');
    await tester.tap(sub);
    await tester.pump();
    print('tap −');
    await tester.tap(five);
    await tester.pump();
    print('tap 5');
    await tester.tap(percent);
    await tester.pump();
    print('tap %');

    print('checking result');
    expect(find.widgetWithText(TextField, '−1239.0'), findsOneWidget);
    print('test 1+2*31÷-5% == −1239.0 succeed');

    await tester.tap(clear);
    await tester.pump();
    print('tap clear');
  });
}
