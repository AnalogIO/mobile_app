import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The type of validation to apply to the form input.
enum FormInputType { email, nonEmptyString }

/// A simple form with a text field and a submit button.
class AnalogForm extends StatefulWidget {
  const AnalogForm({
    required this.labelText,
    required this.submitText,
    required this.onSubmit,
    required this.errorMessage,
    this.hintText,
    this.initialValue = '',
    this.inputType = FormInputType.nonEmptyString,
    super.key,
  });

  /// Label to show inside the text field.
  final String labelText;

  /// Text to show below the text field as a hint.
  final String? hintText;

  /// Text to show on the submit button.
  final String submitText;

  /// Initial text value in the text field.
  final String initialValue;

  /// The type of validation to apply.
  final FormInputType inputType;

  /// Error message to show when validation fails.
  final String errorMessage;

  /// Called when the form is submitted with valid input.
  final void Function(String text) onSubmit;

  @override
  State<AnalogForm> createState() => _AnalogFormState();
}

class _AnalogFormState extends State<AnalogForm> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String value) {
    switch (widget.inputType) {
      case FormInputType.email:
        final regex = RegExp(r'^[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]{2,}');
        if (!regex.hasMatch(value)) {
          return widget.errorMessage;
        }
      case FormInputType.nonEmptyString:
        if (value.trim().isEmpty) {
          return widget.errorMessage;
        }
    }
    return null;
  }

  bool get _isValid => _validate(_controller.text) == null;

  void _onChanged(String value) {
    // Clear error message on input change
    setState(() => _errorText = null);
  }

  void _onSubmit() {
    // The submit button is not enabled when the input is invalid,
    // but the user can still force submit via the software keyboard.
    // It is helpful for the user to see an error message in that case.
    setState(() => _errorText = _validate(_controller.text));
    if (_isValid) {
      widget.onSubmit(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _controller,
            keyboardType: widget.inputType == FormInputType.email
                ? TextInputType.emailAddress
                : TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: _onChanged,
            onFieldSubmitted: (_) => _onSubmit(),
            decoration: InputDecoration(
              labelText: widget.labelText,
              filled: true,
              helperText: widget.hintText ?? '',
              helperMaxLines: 2,
              helperStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              errorText: _errorText,
              errorMaxLines: 2,
            ),
          ),
          const Gap(8),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: _isValid ? _onSubmit : null,
            child: Text(widget.submitText),
          ),
        ],
      ),
    );
  }
}
