import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:lights/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LightsApp());
}

class LightsApp extends StatelessWidget {
  const LightsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Global>(
      create: (_) => Global(context),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
        theme: ThemeData.dark().copyWith(
          textTheme: Typography.whiteHelsinki.copyWith(
            headline1: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
