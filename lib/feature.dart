import 'package:flutter/material.dart';

/// Add a constructor if you feel the need to.
abstract class Feature {
  /// Name of the feature.
  String get name;

  /// Description of the feature.
  String get description;

  /// Returns the settings page widget. If the feature does not have settings, return null.
  Widget? get settingsPage;

  /// Returns an icon for the feature. Only needed if the feature has a settings page. Else return null.
  IconData? get icon;

  /// Will be called when the feature is executed.
  void execute();

  /// Will be called only when the app is opened for the first time. Use to save preferences using SharedPreferences.
  Future<void> init() async {}
}
