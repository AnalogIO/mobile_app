import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

/// Frequently asked questions, ported from the old app and updated for the
/// magic-link / MobilePay flow.
class FaqScreen extends StatelessWidget {
  const new({super.key});

  static const _entries = <String, String>{
    'What is the purpose of this app?':
        "This app replaces Café Analog's physical coffee card. Buy a bundle of "
        'tickets, then swipe one when you pour yourself coffee or show your '
        'phone to the barista when using a ticket for another beverage.',
    'How do I buy tickets?':
        'Open the Tickets tab and choose “Buy drink tickets”. Purchases are '
        'paid with MobilePay; the tickets are added to your account '
        'automatically after the payment is confirmed.',
    'How do I use a ticket?':
        'Open the Tickets tab, select the ticket you want to use, choose your '
        'drink and swipe the card. The receipt is kept under Receipts.',
    "Where'd my tickets go?":
        'Check the Receipts tab for recent purchases and swipes. If there is '
        'no activity there, you may be logged in with a different email.',
    'How do I redeem a voucher?':
        'Open the Tickets tab and tap “Redeem voucher code”, or open the link '
        'in a voucher email.',
    'Can I buy tickets with cash or card?':
        'You can buy physical coffee cards in the café. The app currently '
        'supports MobilePay.',
    'How do I delete my account?':
        'Go to Settings → Delete my account. We send a verification link to '
        'your email; opening it anonymises your account.',
    "Something doesn't seem to work.":
        'Go to Settings → Contact us to report a bug or send us feedback.',
  };

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'FAQ',
      children: [
        for (final entry in _entries.entries)
          ExpansionTile(
            title: Text(entry.key),
            childrenPadding: const .fromLTRB(16, 0, 16, 16),
            expandedCrossAxisAlignment: .start,
            children: [Text(entry.value)],
          ),
      ],
    );
  }
}
