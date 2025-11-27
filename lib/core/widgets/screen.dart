import 'package:cafe_analog_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Screen extends StatelessWidget {
  const Screen({
    required this.name,
    required this.children,
    this.onRefresh,
    super.key,
  });

  final String name;
  final List<Widget> children;

  /// Optional callback for pull-to-refresh functionality.
  ///
  /// Setting this value enables pull-to-refresh on this screen. It is disabled
  /// by default.
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      children: [...children, const Gap(16)],
    );

    return Scaffold(
      appBar: AnalogAppBar(title: name),
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: listView,
            )
          : listView,
    );
  }
}
