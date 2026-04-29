import 'package:cafe_analog_app/core/dialog.dart';
import 'package:cafe_analog_app/features/redeem_voucher/redeem_voucher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A screen that wraps [RedeemVoucherScreen] to handle redeeming a voucher
/// from a deep link.
class RedeemVoucherDeepLinkFlow extends StatefulWidget {
  const RedeemVoucherDeepLinkFlow({required this.voucherCode, super.key});

  final String voucherCode;

  @override
  State<RedeemVoucherDeepLinkFlow> createState() =>
      _RedeemVoucherDeepLinkFlowState();
}

class _RedeemVoucherDeepLinkFlowState extends State<RedeemVoucherDeepLinkFlow> {
  @override
  void initState() {
    super.initState();
    // Needs to be wrapped in a delayed future to ensure the dialog is shown
    // after the screen is built: https://stackoverflow.com/a/52062540
    Future.delayed(Duration.zero, _handleDeepLink);
  }

  Future<void> _handleDeepLink() async {
    final shouldRedeem = await showAnalogDialog<bool>(
      context: context,
      title: 'Redeem voucher?',
      content: 'Confirm to redeem voucher with code "${widget.voucherCode}"',
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => context.pop(true),
          child: const Text('Confirm'),
        ),
      ],
    );
    if (!mounted) return;
    if (shouldRedeem != true) return;

    final _ = redeemVoucher(
      context: context,
      voucherCode: widget.voucherCode,
      onFailure: (reason) => showAnalogDialog<void>(
        context: context,
        title: 'Failed to redeem voucher',
        content: reason,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RedeemVoucherScreen.prefilled(
      initialVoucherCode: widget.voucherCode,
    );
  }
}
