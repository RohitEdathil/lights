import 'package:flutter/widgets.dart';
import 'package:lights/feature.dart';

class FavouritesFeature extends Feature {
  late BuildContext context;

  @override
  get name => 'Favourites';

  @override
  get description =>
      'Features added to favourites are available in this section.';

  @override
  void execute() {}

  @override
  Widget? get settingsPage => null;

  @override
  IconData? get icon => null;
}
