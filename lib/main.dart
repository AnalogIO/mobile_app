import 'package:cafe_analog_app/app.dart';
import 'package:cafe_analog_app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
