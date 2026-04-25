import 'dart:async';

import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildForm({
  String initialValue = '',
  String errorMessage = 'Please enter a value',
  FutureOr<void> Function(String text, void Function(String message) setError)?
  onSubmit,
}) {
  return MaterialApp(
    home: Scaffold(
      body: AnalogForm(
        labelText: 'Label',
        submitText: 'Submit',
        errorMessage: errorMessage,
        initialValue: initialValue,
        onSubmit: onSubmit ?? (_, _) {},
      ),
    ),
  );
}

void main() {
  testWidgets('submit button enables when input becomes valid', (tester) async {
    await tester.pumpWidget(_buildForm());

    FilledButton submitButton() =>
        tester.widget<FilledButton>(find.byType(FilledButton));

    expect(submitButton().onPressed, isNull);

    await tester.enterText(find.byType(TextFormField), 'voucher-123');
    await tester.pump();

    expect(submitButton().onPressed, isNotNull);
  });

  testWidgets('shows validation error for invalid submit', (tester) async {
    await tester.pumpWidget(_buildForm());

    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('Please enter a value'), findsOneWidget);
  });

  testWidgets('shows and clears callback-set errors', (tester) async {
    await tester.pumpWidget(
      _buildForm(
        initialValue: 'ok',
        onSubmit: (_, setError) {
          setError('Request failed');
        },
      ),
    );

    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Request failed'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'ok2');
    await tester.pump();

    expect(find.text('Request failed'), findsNothing);
  });

  testWidgets('validation error takes precedence over callback-set error', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildForm(
        initialValue: 'ok',
        onSubmit: (_, setError) {
          setError('Request failed');
        },
      ),
    );

    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Request failed'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();

    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('Please enter a value'), findsOneWidget);
    expect(find.text('Request failed'), findsNothing);

    await tester.enterText(find.byType(TextFormField), 'hello');
    await tester.pump();

    expect(find.text('Please enter a value'), findsNothing);
    expect(find.text('Request failed'), findsNothing);
  });
}
