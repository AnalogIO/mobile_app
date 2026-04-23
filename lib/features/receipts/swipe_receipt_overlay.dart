import 'package:cafe_analog_app/core/responsive.dart';
import 'package:cafe_analog_app/features/receipts/swipe_receipt.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SwipeReceiptOverlay {
  static Future<void> show({
    required String productName,
    required String drinkName,
    required DateTime timeUsed,
    required bool isTestEnvironment,
    required String status,
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surface.withAlpha(225),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(deviceIsSmall(context) ? 24 : 48),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeReceipt(
                  productName: productName,
                  drinkName: drinkName,
                  time: timeUsed,
                  isTestEnvironment: isTestEnvironment,
                ),
                const Gap(12),
                const Text(
                  'Tap anywhere to dismiss',
                  // style: AppTextStyle.explainerBright,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
