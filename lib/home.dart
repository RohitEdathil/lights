import 'package:flutter/material.dart';
import 'package:lights/globals.dart';
import 'package:lights/settings/settings_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  _switchSection(BuildContext context) {
    Provider.of<Global>(context, listen: false).switchSection();
  }

  _sayTitle(BuildContext context) =>
      Provider.of<Global>(context, listen: false).sayTitle();

  _sayDesc(BuildContext context) =>
      Provider.of<Global>(context, listen: false).sayDesc();

  _handleDrag(DragEndDetails details, BuildContext context) {
    if ((details.primaryVelocity ?? 0) > 0) {
      Provider.of<Global>(context, listen: false).left();
    } else {
      Provider.of<Global>(context, listen: false).right();
    }
  }

  _execute(BuildContext context) {
    Provider.of<Global>(context, listen: false).execute();
  }

  @override
  Widget build(BuildContext context) {
    final title = Provider.of<Global>(context).title;
    final init = Provider.of<Global>(context, listen: false).initialized;
    if (init) {
      _sayTitle(context);
    }
    return !init
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onVerticalDragEnd: (_) => _switchSection(context),
            onHorizontalDragEnd: (details) => _handleDrag(details, context),
            onDoubleTap: () => _sayDesc(context),
            onLongPress: () => _execute(context),
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.settings_rounded),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsView())),
                ),
              ),
            ),
          );
  }
}
