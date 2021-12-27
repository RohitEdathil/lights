import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:provider/provider.dart';

class WeatherSettings extends StatefulWidget {
  const WeatherSettings({Key? key}) : super(key: key);

  @override
  State<WeatherSettings> createState() => _WeatherSettingsState();
}

class _WeatherSettingsState extends State<WeatherSettings> {
  @override
  Widget build(BuildContext context) {
    final global = Provider.of<Global>(context, listen: false);
    final location = TextEditingController(
        text: global.prefs.getString('weather.location')!);
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather Settings"),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  controller: location,
                  onChanged: (value) {
                    global.prefs.setString('weather.location', value);
                  },
                  decoration: const InputDecoration(
                      labelText: 'Location', border: OutlineInputBorder())),
            ),
            ListTile(
              title: const Text("Unit"),
              trailing: DropdownButton<String>(
                value: global.prefs.getString('weather.unit')!,
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    global.prefs.setString('weather.unit', value);
                  });
                },
                items: ['Celsius', 'Fahrenheit'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
