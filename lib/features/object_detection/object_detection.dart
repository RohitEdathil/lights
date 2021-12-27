import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lights/feature.dart';
import 'package:tflite/tflite.dart';

class DetectionFeature extends Feature {
  final FlutterTts tts;
  DetectionFeature({required this.tts});
  @override
  String get name => "Object Detection";
  @override
  String get description => "Detects the object infront of the camera";
  @override
  IconData? get icon => null;
  @override
  Widget? get settingsPage => null;

  @override
  void execute() async {
    await tts.speak("Starting Detection");
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite", labels: "assets/labels.txt");
    final camera = CameraController(
        (await availableCameras())[0], ResolutionPreset.low,
        enableAudio: false);
    await camera.initialize();

    final detections = await Tflite.detectObjectOnImage(
      path: (await camera.takePicture()).path,
      model: "SSDMobileNet",
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.4,
      numResultsPerClass: 1,
    );
    if (detections!.isEmpty) {
      tts.speak("I can't see anything");
      return;
    }
    print(detections);
    await tts.speak("${detections[0]["detectedClass"] ?? "Nothing"} detected");
  }
}
