import 'package:flutter/material.dart';

// TODO(marfavi): Is it possible to give an enum to the `ChoiceChip` widget to
//  avoid using an int for the selected index? This would be more type-safe.
class AnalogChoiceChips extends StatelessWidget {
  const AnalogChoiceChips({
    required this.labels,
    required this.selected,
    required this.onChange,
    super.key,
  });

  final List<String> labels;
  final int selected;
  final void Function(int newIndex) onChange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 4,
        children: List.generate(
          labels.length,
          (index) => ChoiceChip(
            selectedColor: Theme.of(context).colorScheme.secondary,
            labelStyle: TextStyle(
              color: selected == index
                  ? Theme.of(context).colorScheme.onSecondary
                  : null,
            ),
            showCheckmark: false,
            label: Text(labels[index]),
            selected: selected == index,
            onSelected: (didChange) {
              if (didChange) onChange(index);
            },
          ),
        ),
      ),
    );
  }
}
