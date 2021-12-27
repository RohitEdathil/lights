import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:lights/settings/order_settings.dart';
import 'package:lights/settings/speech_settings.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileList = [
      Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          "App Settings",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
      const SettingsTile(
        icon: Icons.record_voice_over_rounded,
        title: "Speech",
        child: SpeechSettings(),
      ),
      const SettingsTile(
        icon: Icons.view_column,
        title: "Features",
        child: OrderSettings(),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          "Feature Settings",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
    ];

    for (var f
        in Provider.of<Global>(context, listen: false).allFeatures.values) {
      if (f.icon != null && f.settingsPage != null) {
        tileList.add(
            SettingsTile(title: f.name, icon: f.icon!, child: f.settingsPage!));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: tileList,
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const SettingsTile(
      {Key? key, required this.title, required this.icon, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.black,
      textColor: Colors.black,
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
            final tween2 = Tween<double>(begin: 0.0, end: 1);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.ease,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: FadeTransition(
                opacity: tween2.animate(curvedAnimation),
                child: child,
              ),
            );
          },
        ));
      },
    );
  }
}
