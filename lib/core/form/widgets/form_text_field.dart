part of 'form.dart';

class _FormTextField extends StatelessWidget {
  _FormTextField({
    required this.label,
    required this.onChanged,
    this.initialValue,
    this.hint,
    this.maxLength,
    TextFieldType textFieldType = TextFieldType.text,
    this.loading = false,
    this.showCheckMark = false,
    this.onEditingComplete,
    this.inputValidators = const [],
  }) : type = switch (textFieldType) {
         TextFieldType.email => TextInputType.emailAddress,
         TextFieldType.text => TextInputType.text,
       };

  final String label;
  final String? initialValue;
  final String? hint;
  final int? maxLength;
  final TextInputType type;
  final bool loading;
  final bool showCheckMark;
  final void Function(String) onChanged;
  final void Function()? onEditingComplete;
  final List<InputValidator> inputValidators;

  @override
  Widget build(BuildContext context) {
    StatelessWidget? suffixIcon() {
      if (loading) {
        return _FormTextFieldSpinner();
      }
      if (showCheckMark) {
        return Icon(
          Icons.check_circle_outline,
          color: Theme.of(context).colorScheme.secondary,
        );
      }
      return null;
    }

    return BlocBuilder<FormBloc, FormState>(
      builder: (context, state) {
        final maybeError = state.error.fold((l) => l, (r) => null);
        // return TextFormField(
        //   autofocus: true,
        //   autocorrect: false,
        //   enableSuggestions: false,
        //   decoration: InputDecoration(
        //     labelText: label,
        //     helperText: hint,
        //     errorText: state.shouldDisplayError ? maybeError : null,
        //     suffixIcon: suffixIcon(),
        //     filled: true,
        //     border: UnderlineInputBorder(
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(12),
        //         topRight: Radius.circular(12),
        //       ),
        //     ),
        //   ),
        // );

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            initialValue: initialValue,
            autofocus: true,
            keyboardType: type,
            textInputAction: TextInputAction.done,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            maxLength: maxLength,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              helperText: hint,
              helperMaxLines: 2,
              helperStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              errorText: state.shouldDisplayError ? maybeError : null,
              errorMaxLines: 2,
              suffixIcon: suffixIcon(),
            ),
          ),
        );
      },
    );
  }
}

class _FormTextFieldSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: 12,
        height: 12,
        child: Center(
          child: CircularProgressIndicator(
            // color: AppColors.secondary,
            strokeWidth: 2.2,
          ),
        ),
      ),
    );
  }
}
