import 'package:cafe_analog_app/app/view/app.dart';
import 'package:cafe_analog_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Screen extends StatelessWidget {
  /// Creates a Screen with a ListView body and optional
  /// pull-to-refresh functionality.
  Screen.listView({
    required this.name,
    required List<Widget> children,
    this.onRefresh,
    super.key,
  }) : _body = ListView(
         children: [...children, const Gap(16)],
       );

  /// Creates a Screen with a custom body widget.
  const Screen.withBody({
    required this.name,
    required Widget body,
    super.key,
  }) : _body = body,
       onRefresh = null;

  final String name;

  /// Optional callback for pull-to-refresh functionality.
  ///
  /// Setting this value enables
  /// pull-to-refresh on this screen. It is disabled by default.
  final Future<void> Function()? onRefresh;

  final Widget _body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnalogAppBar(
        title: name,
        onBrightnessChanged: (brightness) {
          AppBrightnessProvider.of(context).onBrightnessChanged(brightness);
        },
      ),
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: _body,
            )
          : _body,
    );
  }
}
