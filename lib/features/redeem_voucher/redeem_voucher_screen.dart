import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class RedeemVoucherScreen extends StatelessWidget {
  const RedeemVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Redeem voucher',
      body: AnalogForm(
        labelText: 'Voucher code',
        submitText: 'Redeem',
        errorMessage: 'Please enter a voucher code',
        onSubmit: (value) {
          // TODO(marfavi): Handle actual voucher code submission
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Redeemed voucher code: $value')),
          );
        },
      ),
    );
  }
}
