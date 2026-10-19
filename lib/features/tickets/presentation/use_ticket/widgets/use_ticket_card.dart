import 'package:cafe_analog_app/features/tickets/tickets.dart';
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
    required this.initialSelectedDrink,
    required this.onTicketUsed,
    super.key,
  });

  final int ticketId;
  final String ticketName;
  final List<Drink> eligibleDrinks;
  final Drink? initialSelectedDrink;
  final ValueChanged<Drink> onTicketUsed;

  @override
  State<UseTicketCard> createState() => _UseTicketCardState();
}

class _UseTicketCardState extends State<UseTicketCard> {
  late bool _isSwiping;
  Drink? _selectedDrink;

  @override
  void initState() {
    super.initState();
    _selectedDrink = widget.initialSelectedDrink;

    // If there's only one eligible drink, select it and
    // skip straight to the swipe state.
    if (widget.eligibleDrinks.length == 1) {
      _selectedDrink = widget.eligibleDrinks.first;
      _isSwiping = true;
      return;
    }

    _isSwiping = false;
  }

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
          firstChild: _SelectDrinkContent(
            drinks: widget.eligibleDrinks,
            selectedDrink: _selectedDrink,
            onDrinkSelected: (item) {
              setState(() => _selectedDrink = item);
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
