import 'package:cafe_analog_app/core/failures.dart';

sealed class PurchaseFailure extends Failure {
  const PurchaseFailure(super.reason);
}

final class PurchaseInitiationFailure extends PurchaseFailure {
  const PurchaseInitiationFailure(super.reason);
}

sealed class PurchaseVerificationFailure extends PurchaseFailure {
  const PurchaseVerificationFailure(super.reason);
}

final class PurchaseCancelledByUser extends PurchaseVerificationFailure {
  const PurchaseCancelledByUser() : super('You cancelled the purchase.');
}

/// The payment provider hasn't confirmed the payment to the backend yet, even
/// after waiting a while. This is not necessarily a failure: the purchase is
/// completed (and the tickets issued) once the confirmation arrives.
final class PurchasePending extends PurchaseVerificationFailure {
  const PurchasePending()
    : super(
        "We haven't received confirmation of your payment yet. "
        'If you completed the payment, your tickets will appear shortly.',
      );
}

final class PurchaseUnexpectedFailure extends PurchaseVerificationFailure {
  const PurchaseUnexpectedFailure([String? reason])
    : super(
        reason ??
            'Purchase could not be verified for an unexpected reason. '
                'Double-check with MobilePay that the purchase went through.',
      );
}
