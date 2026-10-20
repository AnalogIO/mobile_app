/// Domain-level status of a ticket purchase receipt.
///
/// Kept separate from the generated API enum so `presentation/` never sees
/// generated types and an unknown backend value can be turned into a failure.
enum PurchaseStatus {
  completed,
  cancelled,
  pendingPayment,
  refunded,
  expired;

  String get label => switch (this) {
    PurchaseStatus.completed => 'Completed',
    PurchaseStatus.cancelled => 'Cancelled',
    PurchaseStatus.pendingPayment => 'Pending payment',
    PurchaseStatus.refunded => 'Refunded',
    PurchaseStatus.expired => 'Expired',
  };
}
