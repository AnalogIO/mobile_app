class InitiatedMobilePayPayment {
  const InitiatedMobilePayPayment({
    required this.orderId,
    required this.mobilePayRedirectUri,
  });

  final int orderId;
  final Uri mobilePayRedirectUri;
}
