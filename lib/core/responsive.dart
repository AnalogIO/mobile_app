import 'package:flutter/material.dart';

/// Returns `true` if the device is <= 325 px wide (iPhone 5S and similar).
bool deviceIsSmall(BuildContext context) =>
    MediaQuery.of(context).size.width <= 325;
