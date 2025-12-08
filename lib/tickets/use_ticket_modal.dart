import 'package:cafe_analog_app/tickets/ticket_card.dart';
import 'package:flutter/material.dart';

class UseTicketModal extends StatelessWidget {
  const UseTicketModal({
    required this.name,
    required this.clipsLeft,
    super.key,
  });

  final String name;
  final int clipsLeft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TicketCard(
                name: name,
                clipsLeft: clipsLeft,
                backgroundImage: '',
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
