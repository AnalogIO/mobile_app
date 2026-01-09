import 'package:cafe_analog_app/tickets/next_button.dart';
import 'package:cafe_analog_app/tickets/swipe_ticket_modal.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return TicketCardBase(
      id: 0,
      name: name,
      backgroundImage: backgroundImage,
      children: [
        Text(
          'Select a drink to spend your ticket on',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        const Gap(36),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: DropdownMenu(
                // fills out the full width
                expandedInsets: EdgeInsets.zero,
                enableSearch: false,
                hintText: 'Select drink',
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                ),
                dropdownMenuEntries: menuItems
                    .map((item) => DropdownMenuEntry(value: item, label: item))
                    .toList(),
              ),
            ),
            NextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  PageRouteBuilder<void>(
                    opaque: false,
                    barrierColor: Colors.transparent,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SwipeTicketModal(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
