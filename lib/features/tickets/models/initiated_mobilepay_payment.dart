class InitiatedMobilePayPayment {
  const new({required this.orderId, required this.mobilePayRedirectUri});

  final int orderId;
  final Uri mobilePayRedirectUri;
}
