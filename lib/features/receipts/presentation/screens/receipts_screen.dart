import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/presentation/widgets/receipts_list_entry.dart';
import 'package:cafe_analog_app/features/tickets/models/drink.dart';
import 'package:cafe_analog_app/features/tickets/models/purchasable_ticket_group.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    // Mock products for demonstration
    const cappuccino = PurchasableTicketGroup(
      id: 1,
      title: 'Cappuccino',
      description: 'Creamy cappuccino with foam',
      numberOfTickets: 5,
      priceDKK: 120,
      eligibleDrinks: <Drink>[],
    );

    const caffeLatte = PurchasableTicketGroup(
      id: 2,
      title: 'Caffè Latte',
      description: 'Smooth latte with steamed milk',
      numberOfTickets: 10,
      priceDKK: 230,
      eligibleDrinks: <Drink>[],
    );

    // Generate all receipts
    final allReceipts =
        List.generate(
          15,
          (index) {
            final isSwipe = index % 5 != 0;
            final products = [cappuccino, caffeLatte];
            final product = products[index % 2];
            final day = 4 - (index ~/ 5);
            final hour = 11 + (index % 5);
            final minute = (index % 5) * 12;
            return ReceiptsListEntry(
              product: product,
              date: '0$day.05.2022 $hour:${minute.toString().padLeft(2, '0')}',
              isSwipe: isSwipe,
            );
          },
        )..sort(
          (a, b) => b.date.compareTo(a.date),
        ); // Sort chronologically (newest first)

    // Filter receipts based on selected filter
    final filteredReceipts = switch (_selectedFilter) {
      0 => allReceipts, // Show all
      1 =>
        allReceipts.where((entry) => entry.isSwipe).toList(), // Ticket swipes
      2 => allReceipts.where((entry) => !entry.isSwipe).toList(), // Purchases
      3 => allReceipts.where((entry) => entry.isSwipe).toList(), // Vouchers
      _ => allReceipts, // Show all
    };

    return Screen.listView(
      name: 'Receipts',
      children: [
        AnalogChoiceChips(
          labels: const ['Show all', 'Ticket swipes', 'Purchases', 'Vouchers'],
          selected: _selectedFilter,
          onChange: (newindex) {
            setState(() {
              _selectedFilter = newindex;
            });
          },
        ),
        // TODO(marfavi): Load actual activity entries
        ...filteredReceipts,
        const Gap(16),
      ],
    );
  }
}
