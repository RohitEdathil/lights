import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:provider/provider.dart';

class CallSettings extends StatefulWidget {
  const CallSettings({Key? key}) : super(key: key);

  @override
  State<CallSettings> createState() => _CallSettingsState();
}

class _CallSettingsState extends State<CallSettings> {
  @override
  Widget build(BuildContext context) {
    final global = Provider.of<Global>(context, listen: false);
    final number =
        TextEditingController(text: global.prefs.getString('call.number')!);
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Call Settings"),
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
                  controller: number,
                  onChanged: (value) {
                    global.prefs.setString('call.number', value);
                  },
                  decoration: const InputDecoration(
                      labelText: 'Phone Number', border: OutlineInputBorder())),
            ),
          ],
        ),
      ),
    );
  }
}
