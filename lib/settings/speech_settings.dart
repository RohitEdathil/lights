import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:provider/provider.dart';

class SpeechSettings extends StatefulWidget {
  const SpeechSettings({Key? key}) : super(key: key);

  @override
  State<SpeechSettings> createState() => _SpeechSettingsState();
}

class _SpeechSettingsState extends State<SpeechSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech Settings"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.volume_up_rounded),
        onPressed: () => Provider.of<Global>(context, listen: false)
            .say("The quick brown fox jumps over the lazy dog"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Speed",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
            trailing: FractionallySizedBox(
              widthFactor: 0.7,
              child: Slider(
                  value: Provider.of<Global>(context).prefs.getDouble("speed")!,
                  onChanged: (v) {
                    Provider.of<Global>(context, listen: false)
                        .prefs
                        .setDouble("speed", v);
                    setState(() {});
                  },
                  min: 0.1,
                  max: 1,
                  divisions: 10,
                  label: "Speed"),
            ),
          ),
          ListTile(
            title: Text("Volume",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
            trailing: FractionallySizedBox(
              widthFactor: 0.7,
              child: Slider(
                  value:
                      Provider.of<Global>(context).prefs.getDouble("volume")!,
                  onChanged: (v) {
                    Provider.of<Global>(context, listen: false)
                        .prefs
                        .setDouble("volume", v);
                    setState(() {});
                  },
                  min: 0.1,
                  max: 1,
                  divisions: 10,
                  label: "Volume"),
            ),
          ),
        ],
      ),
    );
  }
}
