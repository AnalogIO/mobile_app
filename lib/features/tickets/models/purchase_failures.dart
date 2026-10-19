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

// shouldn't happen since we only verify purchases after mobilepay redirects
// back to the app, but we want to be safe and handle this case as well
final class PurchasePending extends PurchaseVerificationFailure {
  const PurchasePending()
    : super(
        'Purchase is still pending. '
        'If you just completed the purchase, '
        'refresh the Tickets page after a few moments. ',
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
