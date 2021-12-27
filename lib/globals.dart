import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lights/feature.dart';
import 'package:lights/features/call/call.dart';
import 'package:lights/features/date/date.dart';
import 'package:lights/features/favourite.dart';
import 'package:lights/features/home.dart';
import 'package:lights/features/object_detection/object_detection.dart';
import 'package:lights/features/time/time.dart';
import 'package:lights/features/weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global extends ChangeNotifier {
  final tts = FlutterTts();
  late String _title = '';
  Section section = Section.home;
  late Feature current;
  int pos = 0;
  late Map<String, Feature> allFeatures;
  late SharedPreferences _prefs;
  bool initialized = false;
  bool isFirstTime = true;

  List<String> homeFeatures = [];
  List<String> favouriteFeatures = [];
  Global(BuildContext context) {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    allFeatures = {
      "home": HomeFeature(),
      "favourites": FavouritesFeature(),

      // Register new features below
      "weather": WeatherFeature(tts: tts, prefs: _prefs),
      "data": DateFeature(tts: tts),
      "time": TimeFeature(tts: tts, prefs: _prefs),
      "call": CallFeature(prefs: _prefs),
      "object_detection": DetectionFeature(tts: tts),
    };
    current = allFeatures['home']!;
    _title = current.name;
    isFirstTime = _prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await _prefs.setBool('isFirstTime', false);
      isFirstTime = false;

      await _prefs.setStringList(
          'homeFeatures', allFeatures.keys.toList()..remove('favourites'));
      await _prefs.setStringList('favouriteFeatures', ['favourites']);
      await _prefs.setDouble('volume', 0.5);
      await _prefs.setDouble('speed', 0.5);
      for (var f in allFeatures.values) {
        await f.init();
      }
    }

    await tts.setVolume(_prefs.getDouble('volume')!);
    await tts.setSpeechRate(_prefs.getDouble('speed')!);
    homeFeatures = _prefs.getStringList('homeFeatures')!;
    favouriteFeatures = _prefs.getStringList('favouriteFeatures')!;
    initialized = true;
    notifyListeners();
  }

  SharedPreferences get prefs {
    return _prefs;
  }

  void switchSection() {
    if (section == Section.home) {
      section = Section.favourites;
      current = allFeatures['favourites']!;
    } else {
      section = Section.home;
      current = allFeatures['home']!;
    }
    pos = 0;
    _title = current.name;

    notifyListeners();
  }

  void saveFeatureData() {
    prefs.setStringList('homeFeatures', homeFeatures);
    prefs.setStringList('favouriteFeatures', favouriteFeatures);
  }

  void left() {
    final currentList =
        section == Section.home ? homeFeatures : favouriteFeatures;
    if (pos == 0) {
      return;
    } else {
      pos--;
      current = allFeatures[currentList[pos]]!;
      title = current.name;
      notifyListeners();
    }
  }

  void right() {
    final currentList =
        section == Section.home ? homeFeatures : favouriteFeatures;
    if (pos == currentList.length - 1) {
      return;
    } else {
      pos++;
      current = allFeatures[currentList[pos]]!;
      title = current.name;
      notifyListeners();
    }
  }

  void execute() {
    current.execute();
  }

  void say(String text) async {
    await tts.setVolume(_prefs.getDouble('volume')!);
    await tts.setSpeechRate(_prefs.getDouble('speed')!);
    tts.speak(text);
  }

  Future<void> sayAsync(String text) async {
    say(text);
    await tts.awaitSpeakCompletion(true);
  }

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  sayTitle() => say(current.name);
  sayDesc() => say('${current.name}.${current.description}');

  String get title => _title;
}

enum Section {
  home,
  favourites,
}
