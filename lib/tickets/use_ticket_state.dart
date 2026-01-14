part of 'select_menu_item_ticket_card.dart';

/// The current state of the ticket card.
sealed class UseTicketState {
  const UseTicketState();
}

/// User is selecting a menu item from the dropdown.
class SelectingMenuItem extends UseTicketState {
  const SelectingMenuItem();
}

/// User has selected a menu item and can swipe to use the ticket.
class SwipingTicket extends UseTicketState {
  const SwipingTicket(this.selectedMenuItem);

  final String selectedMenuItem;
}
