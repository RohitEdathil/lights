import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lights/feature.dart';

class DateFeature extends Feature {
  final FlutterTts tts;
  DateFeature({required this.tts});
  @override
  String get name => "Date";
  @override
  String get description => "Tells the current date";
  @override
  IconData? get icon => null;
  @override
  Widget? get settingsPage => null;

  @override
  void execute() async {
    var now = DateTime.now();
    final days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ];
    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    await tts.speak(
        "It is ${days[now.weekday]} ${now.day} ${months[now.month - 1]} ${now.year}");
  }
}
