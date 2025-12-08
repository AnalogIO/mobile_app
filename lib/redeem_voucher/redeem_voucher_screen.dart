import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class RedeemVoucherScreen extends StatelessWidget {
  const RedeemVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Redeem voucher',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(labelText: 'Voucher code'),
        ),
      ),
    );
  }
}
