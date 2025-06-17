import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconswitcher/iconswitcher.dart';

Widget buildSwitcher({bool initialLeft = true, bool enabled = true}) {
  return MaterialApp(
    home: Scaffold(
      body: IconSwitcher(
        width: 100,
        height: 50,
        marginTop: 0,
        duration: const Duration(milliseconds: 0),
        icon1: Icons.add,
        icon2: Icons.remove,
        color1: Colors.red,
        color2: Colors.blue,
        backgroundColor: Colors.white,
        firstIconSelectedColor: Colors.green,
        secondIconSelectedColor: Colors.yellow,
        initialLeft: initialLeft,
        enabled: enabled,
      ),
    ),
  );
}

void main() {
  testWidgets('Initial icon corresponds to initialLeft', (tester) async {
    await tester.pumpWidget(buildSwitcher(initialLeft: false));
    await tester.pumpAndSettle();

    final AnimatedContainer container = tester.widget(find.byType(AnimatedContainer));
    final BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.yellow));
  });

  testWidgets('Tapping icons toggles when enabled', (tester) async {
    await tester.pumpWidget(buildSwitcher(initialLeft: true, enabled: true));
    await tester.pumpAndSettle();

    AnimatedContainer container = tester.widget(find.byType(AnimatedContainer));
    BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.green));

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    container = tester.widget(find.byType(AnimatedContainer));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.yellow));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    container = tester.widget(find.byType(AnimatedContainer));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.green));
  });

  testWidgets('Taps ignored when disabled', (tester) async {
    await tester.pumpWidget(buildSwitcher(initialLeft: true, enabled: false));
    await tester.pumpAndSettle();

    AnimatedContainer container = tester.widget(find.byType(AnimatedContainer));
    BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.green));

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    container = tester.widget(find.byType(AnimatedContainer));
    decoration = container.decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.green));
  });
}
