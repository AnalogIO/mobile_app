import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectMenuItemTicketCard extends StatelessWidget {
  const SelectMenuItemTicketCard({
    required this.name,
    required this.menuItems,
    required this.backgroundImage,
    super.key,
  });

  final String name;
  final List<String> menuItems;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return TicketCardBase(
      name: name,
      backgroundImage: backgroundImage,
      children: [
        Text(
          'Select a drink to spend your ticket on',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        const Gap(48),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: DropdownButton(
                  dropdownColor: Theme.of(
                    context,
                  ).colorScheme.surface,
                  items: menuItems
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (String? value) {},
                ),
              ),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }
}
