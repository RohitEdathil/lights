import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lights/feature.dart';
import 'package:http/http.dart';
import 'package:lights/features/weather/weather_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherFeature implements Feature {
  final FlutterTts tts;
  final SharedPreferences prefs;
  WeatherFeature({required this.tts, required this.prefs});
  @override
  String get name => 'Weather';

  @override
  String get description =>
      'Tells you the current weather information at your set location';

  @override
  void execute() async {
    final location = prefs.getString('weather.location');
    final unit = prefs.getString('weather.unit');
    final request = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=cca43e68a3f049dd9ae84700212712&q=$location");
    try {
      final response = await get(request);
      final data = json.decode(response.body);
      if (data['error'] != null) {
        await tts.speak(data['error']['message']);
        return;
      }
      await tts.speak(
          "Temperature at $location is ${data['current'][unit == "Celsius" ? 'temp_c' : 'temp_f']} degrees $unit.Humidity is ${data['current']['humidity']}%. Precipitation is ${data['current']['precip_mm']}mm");
    } catch (e) {
      tts.speak('No internet connection');
      return;
    }
  }

  @override
  Future<void> init() async {
    await prefs.setString('weather.location', 'London');
    await prefs.setString('weather.unit', 'Celsius');
  }

  @override
  Widget get settingsPage => const WeatherSettings();

  @override
  IconData get icon => Icons.cloud;
}
