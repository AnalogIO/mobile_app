import 'package:equatable/equatable.dart';

sealed class InitiatedPayment extends Equatable {
  const InitiatedPayment({required this.orderId});

  final int orderId;
}

final class InitiatedMobilePayPayment extends InitiatedPayment {
  const InitiatedMobilePayPayment({
    required super.orderId,
    required this.mobilePayRedirectUri,
  });

  final Uri mobilePayRedirectUri;

  @override
  List<Object?> get props => [orderId, mobilePayRedirectUri];
}

final class InitiatedNexiPayment extends InitiatedPayment {
  const InitiatedNexiPayment({
    required super.orderId,
    required this.paymentUrl,
  });

  final Uri paymentUrl;

  @override
  List<Object?> get props => [orderId, paymentUrl];
}
