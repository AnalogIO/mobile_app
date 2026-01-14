import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:cafe_analog_app/tickets/use_ticket/next_button.dart';
import 'package:cafe_analog_app/tickets/use_ticket/slide_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'use_ticket_state.dart';

/// A ticket card that allows the user to select a menu item,
/// then swipe to use the ticket.
///
/// Transitions between states with a fade animation.
class UseTicketCard extends StatefulWidget {
  const UseTicketCard({
    required this.ticketName,
    required this.menuItems,
    required this.backgroundImagePath,
    super.key,
  });

  final String ticketName;
  final List<String> menuItems;
  final String backgroundImagePath;

  @override
  State<UseTicketCard> createState() => _UseTicketCardState();
}

class _UseTicketCardState extends State<UseTicketCard>
    with SingleTickerProviderStateMixin {
  UseTicketState _state = const SelectingMenuItem();
  String? _selectedMenuItem;

  /// Animation controller for the fade transition.
  /// 0.0 = SelectingMenuItem fully visible
  /// 1.0 = SwipingTicket fully visible
  late final AnimationController _controller;

  /// Fade out animation for the first half (0.0 - 0.4)
  late final Animation<double> _fadeOutAnimation;

  /// Fade in animation for the second half (0.6 - 1.0)
  late final Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Fade out from 1 to 0 during first 40% of animation
    _fadeOutAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.4, curve: Curves.easeOut),
      ),
    );

    // Fade in from 0 to 1 during last 40% of animation (after 60%)
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToSwipeState() {
    setState(() => _state = SwipingTicket(_selectedMenuItem!));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isSelectingState = _state is SelectingMenuItem;

    return TicketCardBase.customTitleWidget(
      id: 0,
      titleWidget: Stack(
        children: [
          // Menu item title (fades in)
          AnimatedBuilder(
            animation: _fadeInAnimation,
            builder: (context, child) => Opacity(
              opacity: _fadeInAnimation.value,
              child: child,
            ),
            child: Text(_selectedMenuItem ?? ''),
          ),
          // Ticket name title (fades out)
          AnimatedBuilder(
            animation: _fadeOutAnimation,
            builder: (context, child) => Opacity(
              opacity: _fadeOutAnimation.value,
              child: child,
            ),
            child: Text(widget.ticketName),
          ),
        ],
      ),
      backgroundImagePath: widget.backgroundImagePath,
      children: [
        // Stack ensures the height is always the max of both children.
        // IntrinsicHeight allows Positioned.fill children to expand.
        IntrinsicHeight(
          child: Stack(
            children: [
              // Swipe content (defines the height, fades in)
              AnimatedBuilder(
                animation: _fadeInAnimation,
                builder: (context, child) => Opacity(
                  opacity: _fadeInAnimation.value,
                  child: IgnorePointer(
                    ignoring: isSelectingState,
                    child: child,
                  ),
                ),
                child: _SwipeTicketContent(ticketName: widget.ticketName),
              ),
              // Select content (fills the height, fades out)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _fadeOutAnimation,
                  builder: (context, child) => Opacity(
                    opacity: _fadeOutAnimation.value,
                    child: IgnorePointer(
                      ignoring: !isSelectingState,
                      child: child,
                    ),
                  ),
                  child: _SelectMenuItemContent(
                    menuItems: widget.menuItems,
                    selectedMenuItem: _selectedMenuItem,
                    onMenuItemSelected: (item) {
                      setState(() => _selectedMenuItem = item);
                    },
                    onNextPressed: _selectedMenuItem != null
                        ? _goToSwipeState
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
                    .map((item) => DropdownMenuEntry(value: item, label: item))
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

/// Content shown when the user can swipe to use the ticket.
class _SwipeTicketContent extends StatelessWidget {
  const _SwipeTicketContent({
    required this.ticketName,
  });

  final String ticketName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(4),
        Text(
          'Claiming via ticket: $ticketName',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        const Gap(24),
        SlideAction(
          text: 'Use ticket',
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          outerColor: colorScheme.onSurface,
          innerColor: colorScheme.surfaceContainer,
        ),
      ],
    );
  }
}
