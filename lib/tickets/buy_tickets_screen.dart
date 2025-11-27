import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/tickets/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuyTicketsScreen extends StatelessWidget {
  const BuyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      name: 'Buy tickets',
      children: products.map((product) {
        return ListTile(
          title: Text(product.title),
          subtitle: Text(
            '${product.noTickets} tickets • ${product.priceDKK} kr',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.push(
              '/tickets/buy/ticket/${product.title}',
              extra: product,
            );
          },
        );
      }).toList(),
    );
  }
}
