import 'package:cafe_analog_app/app/app.dart';
import 'package:cafe_analog_app/app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
