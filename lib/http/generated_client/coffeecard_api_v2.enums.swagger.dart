import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum UserRole {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Customer')
  customer('Customer'),
  @JsonValue('Barista')
  barista('Barista'),
  @JsonValue('Manager')
  manager('Manager'),
  @JsonValue('Board')
  board('Board');

  final String? value;

  const UserRole(this.value);
}

enum UserGroup {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Customer')
  customer('Customer'),
  @JsonValue('Barista')
  barista('Barista'),
  @JsonValue('Manager')
  manager('Manager'),
  @JsonValue('Board')
  board('Board');

  final String? value;

  const UserGroup(this.value);
}

enum UserState {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Active')
  active('Active'),
  @JsonValue('Deleted')
  deleted('Deleted'),
  @JsonValue('PendingActivition')
  pendingactivition('PendingActivition');

  final String? value;

  const UserState(this.value);
}

enum LoginType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Shifty')
  shifty('Shifty'),
  @JsonValue('App')
  app('App');

  final String? value;

  const LoginType(this.value);
}

enum EnvironmentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Production')
  production('Production'),
  @JsonValue('Test')
  test('Test'),
  @JsonValue('LocalDevelopment')
  localdevelopment('LocalDevelopment');

  final String? value;

  const EnvironmentType(this.value);
}

enum LeaderboardPreset {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Month')
  month('Month'),
  @JsonValue('Semester')
  semester('Semester'),
  @JsonValue('Total')
  total('Total');

  final String? value;

  const LeaderboardPreset(this.value);
}

enum PurchaseStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Completed')
  completed('Completed'),
  @JsonValue('Cancelled')
  cancelled('Cancelled'),
  @JsonValue('PendingPayment')
  pendingpayment('PendingPayment'),
  @JsonValue('Refunded')
  refunded('Refunded'),
  @JsonValue('Expired')
  expired('Expired');

  final String? value;

  const PurchaseStatus(this.value);
}

enum PaymentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MobilePay')
  mobilepay('MobilePay'),
  @JsonValue('FreePurchase')
  freepurchase('FreePurchase');

  final String? value;

  const PaymentType(this.value);
}
