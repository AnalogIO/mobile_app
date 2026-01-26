import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Ensure that the build is clean (i.e. no generated files are out of date)',
    expectBuildClean,
    // skip: true, // Uncomment this line to enable build verification
  );
}
