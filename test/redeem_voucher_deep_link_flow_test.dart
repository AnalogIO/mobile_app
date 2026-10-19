import 'package:cafe_analog_app/features/redeem_voucher/redeem_voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'does not throw when deep-link callback runs after dispose',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RedeemVoucherDeepLinkFlow(voucherCode: 'voucher-code'),
        ),
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      expect(tester.takeException(), isNull);
    },
  );
}
