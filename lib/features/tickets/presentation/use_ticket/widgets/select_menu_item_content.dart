part of 'use_ticket_card.dart';

/// Content shown when the user is selecting a drink.
class _SelectDrinkContent extends StatelessWidget {
  const _SelectDrinkContent({
    required this.drinks,
    required this.selectedDrink,
    required this.onDrinkSelected,
    required this.onNextPressed,
  });

  final List<Drink> drinks;
  final Drink? selectedDrink;
  final ValueChanged<Drink?> onDrinkSelected;
  final VoidCallback? onNextPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(4),
        Text(
          'Select a drink to spend your ticket on',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        const Gap(24),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: DropdownMenu<Drink>(
                expandedInsets: EdgeInsets.zero,
                enableSearch: false,
                hintText: 'Select drink',
                initialSelection: selectedDrink,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                ),
                dropdownMenuEntries: drinks
                    .map(
                      (item) =>
                          DropdownMenuEntry(value: item, label: item.name),
                    )
                    .toList(),
                onSelected: onDrinkSelected,
              ),
            ),
            CircularNextButton(onPressed: onNextPressed),
          ],
        ),
      ],
    );
  }
}
