part of 'use_ticket_card.dart';

/// Content shown when the user is selecting a menu item.
class _SelectMenuItemContent extends StatelessWidget {
  const _SelectMenuItemContent({
    required this.menuItems,
    required this.selectedMenuItem,
    required this.onMenuItemSelected,
    required this.onNextPressed,
  });

  final List<String> menuItems;
  final String? selectedMenuItem;
  final ValueChanged<String?> onMenuItemSelected;
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
              child: DropdownMenu<String>(
                expandedInsets: EdgeInsets.zero,
                enableSearch: false,
                hintText: 'Select drink',
                initialSelection: selectedMenuItem,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                ),
                dropdownMenuEntries: menuItems
                    .map(
                      (item) => DropdownMenuEntry(value: item, label: item),
                    )
                    .toList(),
                onSelected: onMenuItemSelected,
              ),
            ),
            NextButton(onPressed: onNextPressed),
          ],
        ),
      ],
    );
  }
}
