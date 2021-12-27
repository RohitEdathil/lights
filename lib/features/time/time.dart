import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lights/feature.dart';
import 'package:lights/features/time/time_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeFeature extends Feature {
  final FlutterTts tts;
  final SharedPreferences prefs;
  TimeFeature({required this.tts, required this.prefs});
  @override
  String get name => "Time";
  @override
  String get description => "Tells the current time";
  @override
  IconData? get icon => Icons.access_time;
  @override
  Widget? get settingsPage => TimeSettings();

  @override
  void execute() async {
    var now = DateTime.now();
    final format = prefs.getString("time.format")!;
    var hour = now.hour;
    var suff = '';
    if (format == "12 Hour") {
      if (hour > 12) {
        hour -= 12;
        suff = 'PM';
      } else {
        suff = 'AM';
      }
    }
    await tts.speak("The time is $hour ${now.minute} $suff");
  }

  @override
  Future<void> init() async {
    await prefs.setString("time.format", "12 Hour");
  }
}
