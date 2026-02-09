import 'package:cafe_analog_app/app/app_brightness_provider.dart';
import 'package:cafe_analog_app/app/dependencies_provider.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({required this.localStorage, super.key});

  final SharedPreferencesWithCache localStorage;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness appBrightness = .light;

  @override
  Widget build(BuildContext context) {
    return DependenciesProvider(
      localStorage: widget.localStorage,
      child: MaterialApp.router(
        routerConfig: AnalogGoRouter.instance.goRouter,
        theme: ThemeData(
          brightness: appBrightness,
          colorScheme: .fromSeed(
            brightness: appBrightness,
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

  void _setBrightness(Brightness newBrightness) {
    setState(() => appBrightness = newBrightness);
  }
}
