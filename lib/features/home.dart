import 'package:flutter/widgets.dart';
import 'package:lights/feature.dart';

class HomeFeature extends Feature {
  late BuildContext context;

  @override
  @override
  get name => 'Home';

  @override
  get description =>
      'Contains all the active features. Swipe horizontally to navigate between them. Double tap to hear the feature\'s description. Long press to execute it.';

  @override
  void execute() {}

  @override
  Widget? get settingsPage => null;

  @override
  IconData? get icon => null;
}
