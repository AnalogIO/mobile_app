import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/redeem_voucher/redeem_voucher.dart';
import 'package:flutter/material.dart';

class RedeemVoucherScreen extends StatelessWidget {
  const RedeemVoucherScreen({super.key}) : initialVoucherCode = '';

  const RedeemVoucherScreen.prefilled({
    required this.initialVoucherCode,
    super.key,
  });

  final String initialVoucherCode;

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Redeem voucher',
      body: AnalogForm(
        labelText: 'Voucher code',
        submitText: 'Redeem',
        errorMessage: 'Please enter a voucher code',
        initialValue: initialVoucherCode,
        onSubmit: (voucherCode, setError) async {
          return redeemVoucher(
            context: context,
            voucherCode: voucherCode,
            onFailure: setError,
          );
        },
      ),
    );
  }
}
