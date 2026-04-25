import 'package:cafe_analog_app/features/tickets/models/drink.dart';
import 'package:cafe_analog_app/features/tickets/presentation/my_tickets/widgets/ticket_card_base.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'select_menu_item_content.dart';
part 'swipe_ticket_content.dart';

/// A ticket card that allows the user to select a menu item,
/// then swipe to use the ticket.
///
/// Transitions between states with a fade animation.
class UseTicketCard extends StatefulWidget {
  const UseTicketCard({
    required this.ticketId,
    required this.ticketName,
    required this.eligibleDrinks,
    required this.onTicketUsed,
    super.key,
  });

  final int ticketId;
  final String ticketName;
  final List<Drink> eligibleDrinks;
  final ValueChanged<Drink> onTicketUsed;

  @override
  State<UseTicketCard> createState() => _UseTicketCardState();
}

class _UseTicketCardState extends State<UseTicketCard> {
  bool _isSwiping = false;
  Drink? _selectedDrink;

  String get backgroundImagePath {
    // choose background based on some rudimentary logic
    return widget.ticketName.toLowerCase().contains('filter')
        ? 'assets/images/beans_cropped.png'
        : 'assets/images/latteart_cropped.png';
  }

  @override
  Widget build(BuildContext context) {
    // FIXME(marfavi): When title goes from 2 lines to 1 line (or vice versa),
    //  the space between the title and the content is wrong when showing the
    //  title with fewer lines. Might be fixed by wrapping the entire
    //  card in AnimatedFadeSwitcherSized instead of the
    //  title/children separately.
    return TicketCardBase(
      id: widget.ticketId,
      backgroundImagePath: backgroundImagePath,
      title: AnimatedFadeSwitcherSized(
        showSecond: _isSwiping,
        firstChild: Text(widget.ticketName),
        secondChild: Text(_selectedDrink?.name ?? ''),
      ),
      children: [
        AnimatedFadeSwitcherSized(
          showSecond: _isSwiping,
          firstChild: _SelectMenuItemContent(
            menuItems: widget.eligibleDrinks.map((item) => item.name).toList(),
            selectedMenuItem: _selectedDrink?.name,
            onMenuItemSelected: (item) {
              setState(
                () => _selectedDrink = widget.eligibleDrinks.firstWhere(
                  (drink) => drink.name == item,
                ),
              );
            },
            onNextPressed: _selectedDrink != null
                ? () => setState(() => _isSwiping = true)
                : null,
          ),
          secondChild: _SwipeTicketContent(
            ticketName: widget.ticketName,
            onTicketUsed: () => widget.onTicketUsed(_selectedDrink!),
          ),
        ),
      ],
    );
  }
}
