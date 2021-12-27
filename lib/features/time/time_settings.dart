import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:provider/provider.dart';

class TimeSettings extends StatefulWidget {
  const TimeSettings({Key? key}) : super(key: key);

  @override
  State<TimeSettings> createState() => _TimeSettingsState();
}

class _TimeSettingsState extends State<TimeSettings> {
  @override
  Widget build(BuildContext context) {
    final global = Provider.of<Global>(context, listen: false);
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Time Settings"),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            ListTile(
              title: const Text("Format"),
              trailing: DropdownButton<String>(
                value: global.prefs.getString('time.format')!,
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    global.prefs.setString('time.format', value);
                  });
                },
                items: ['24 Hour', '12 Hour'].map((String value) {
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
