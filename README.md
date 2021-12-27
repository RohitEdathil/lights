# Lights

A project aiming to create a platform for visually challenged individuals to make use of their smart phones.

This app currently has a few demo features. These features are just examples of what such a platform can do. **The real beauty of the project is not what it is now but, what it can be.**

## Working

The project aims to solves the challenges by

- Creating an easy to use inteface which only involves a few simple gestures.
- Giving out responses only through voice.
- Enabling other people to contribute to the project by creating new features.

## Usage

There are two main aspects to this.

### The main interface

It contains a large, easily readable text which corresponds to the currently active function.

- `Swiping vertically` will switch between the Home section and the Favourites section.

- `Swiping horizontally` will switch between the functions in that section.

- `Double tapping` will read the description of the function.

- `Long pressing` will execute the function.

### The settings

This section is ment to be used by a regular person whom the user trusts. This person can help the user to change the settings of the app.

#### App Settings

Has the following options divided into sections:

- Speech

  - Adjust speech speed
  - Adjust speech volume

- Feature
  - Reorder the functions
  - Add or remove items from Favorites
  - Enable or disable a functions

#### Feature Settings

Contains all the settings offered by individual functions if they offer any.

## Features

- `Weather` : Tells the weather of a set location
- `Date` : Tells the current date
- `Time` : Tells the current time
- `Call` : Calls a preset number
- `Object Detection` : Detects objects infront of the camera

## Adding a new feature

The central concept of this project is to provide a platform not the features it currently has. So it is crucial to have an easy way to add new features.

### Step 1

Familirase with other features in the lib\features folder. This is the folder where the features are kept. Familiarising will help you in understanding the project structure.

### Step 2

Create a new folder in the lib\features folder. This folder will contain the feature you want to add. Then create a file in this folder called `feature_name.dart`. This file will contain the code for the feature. Then create a file in this folder called `feature_name_settings.dart`. This file will contain the settings page widget for the feature (It is optional for features to offer settings, don't make this file if your feature doesn't have any settings).

### Step 3

Implement your feature by extending the `Feature` class from `lib\feature.dart`.

```dart
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

```

### Step 4

Register your feature in the `lib\globals.dart` file.

```dart
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
```
