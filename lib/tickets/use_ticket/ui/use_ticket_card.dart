import 'package:cafe_analog_app/tickets/my_tickets/ui/ticket_card_base.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/animated_fade_switcher_sized.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/next_button.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/slide_action.dart';
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
    required this.menuItems,
    required this.backgroundImagePath,
    super.key,
  });

  final int ticketId;
  final String ticketName;
  final List<String> menuItems;
  final String backgroundImagePath;

  @override
  State<UseTicketCard> createState() => _UseTicketCardState();
}

class _UseTicketCardState extends State<UseTicketCard> {
  bool _isSwiping = false;
  String? _selectedMenuItem;

  @override
  Widget build(BuildContext context) {
    // FIXME(marfavi): When title goes from 2 lines to 1 line (or vice versa),
    //  the space between the title and the content is wrong when showing the
    //  title with fewer lines. Might be fixed by wrapping the entire
    //  card in AnimatedFadeSwitcherSized instead of the
    //  title/children separately.
    return TicketCardBase(
      id: widget.ticketId,
      backgroundImagePath: widget.backgroundImagePath,
      title: AnimatedFadeSwitcherSized(
        showSecond: _isSwiping,
        firstChild: Text(widget.ticketName),
        secondChild: Text(_selectedMenuItem ?? ''),
      ),
      children: [
        AnimatedFadeSwitcherSized(
          showSecond: _isSwiping,
          firstChild: _SelectMenuItemContent(
            menuItems: widget.menuItems,
            selectedMenuItem: _selectedMenuItem,
            onMenuItemSelected: (item) {
              setState(() => _selectedMenuItem = item);
            },
            onNextPressed: _selectedMenuItem != null
                ? () => setState(() => _isSwiping = true)
                : null,
          ),
          secondChild: _SwipeTicketContent(ticketName: widget.ticketName),
        ),
      ],
    );
  }
}
