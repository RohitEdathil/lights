import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lights/feature.dart';
import 'package:lights/features/call/call_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallFeature extends Feature {
  final SharedPreferences prefs;
  CallFeature({required this.prefs});
  @override
  String get name => "Call";
  @override
  String get description => "Calls a preset Phone Number";
  @override
  IconData? get icon => Icons.call;
  @override
  Widget? get settingsPage => CallSettings();

  @override
  void execute() async {
    await FlutterPhoneDirectCaller.callNumber(prefs.getString("call.number")!);
  }

  @override
  Future<void> init() async {
    await prefs.setString("call.number", "100");
  }
}
