import 'package:cafe_analog_app/app/app_brightness_provider.dart';
import 'package:cafe_analog_app/app/dependencies_provider.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // TODO(marfavi): Remove theme switching when all widgets support system theme
  Brightness _brightness = Brightness.light;

  void _setBrightness(Brightness brightness) {
    setState(() => _brightness = brightness);
  }

  @override
  Widget build(BuildContext context) {
    return DependenciesProvider(
      child: MaterialApp.router(
        routerConfig: AnalogGoRouter.instance.goRouter,
        theme: ThemeData(
          brightness: _brightness,
          colorScheme: ColorScheme.fromSeed(
            brightness: _brightness,
            seedColor: const Color(0xFF785B38),
          ),
        ),
        builder: (context, child) {
          return AppBrightnessProvider(
            onBrightnessChanged: _setBrightness,
            child: child!,
          );
        },
      ),
    );
  }
}
