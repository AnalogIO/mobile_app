part of 'purchase_flow_cubit.dart';

sealed class PurchaseFlowState extends Equatable {
  const PurchaseFlowState();
}

/// Default state, and the state after a completed/failed purchase.
final class PurchaseFlowIdle extends PurchaseFlowState {
  const PurchaseFlowIdle();

  @override
  List<Object?> get props => [];
}

/// The user has sent the purchase request, but the app has not yet received a
/// response from the server.
final class PurchaseInitiating extends PurchaseFlowState {
  const PurchaseInitiating();

  @override
  List<Object?> get props => [];
}

/// The purchase request was successful and the server responded with the
/// initiated purchase containing the MobilePay redirect URI.
final class PurchaseInitiated extends PurchaseFlowState {
  const PurchaseInitiated({required this.initiatedPurchase});

  final InitiatedMobilePayPayment initiatedPurchase;

  @override
  List<Object?> get props => [initiatedPurchase];
}

/// The app is verifying the purchase status with the server after the user has
/// completed the payment in MobilePay and returned to the app.
final class PurchaseVerifying extends PurchaseFlowState {
  const PurchaseVerifying({required this.initiatedPurchase});

  final InitiatedMobilePayPayment initiatedPurchase;

  @override
  List<Object?> get props => [initiatedPurchase];
}

/// Payment was successful and purchase is completed.
final class PurchaseCompleted extends PurchaseFlowState {
  const PurchaseCompleted({required this.successfulPurchase});

  final SuccessfulPurchase successfulPurchase;

  @override
  List<Object?> get props => [successfulPurchase];
}

sealed class PurchaseFailed extends PurchaseFlowState {
  const PurchaseFailed({required this.failure});

  final PurchaseFailure failure;

  @override
  List<Object?> get props => [failure];
}
// sealed class PurchaseFailure extends PurchaseFlowState {
//   const PurchaseFailure({required this.reason});

//   final String reason;

//   @override
//   List<Object?> get props => [reason];
// }

/// Something went wrong during purchase initiation, e.g.
/// network/server error or invalid ticket group.
final class CouldNotInitiatePurchase extends PurchaseFailed {
  const CouldNotInitiatePurchase({required PurchaseInitiationFailure failure})
    : super(failure: failure);
}

/// Something went wrong during purchase verification, e.g.
/// network/server error, no pending purchase found for verification,
/// the purchase is pending or cancelled, etc.
final class CouldNotVerifyPurchase extends PurchaseFailed {
  const CouldNotVerifyPurchase({required PurchaseVerificationFailure failure})
    : super(failure: failure);
}
