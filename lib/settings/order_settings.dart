import 'package:flutter/material.dart';
import 'package:lights/feature.dart';
import 'package:lights/globals.dart';
import 'package:provider/provider.dart';

class OrderSettings extends StatefulWidget {
  const OrderSettings({Key? key}) : super(key: key);

  @override
  State<OrderSettings> createState() => _OrderSettingsState();
}

class _OrderSettingsState extends State<OrderSettings> {
  @override
  Widget build(BuildContext context) {
    final global = Provider.of<Global>(context, listen: false);
    final disabled = global.allFeatures.keys
        .toSet()
        .difference((global.homeFeatures +
                global.favouriteFeatures +
                ['home', 'favourites'])
            .toSet())
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Features"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Favourites",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
            ),
          ),
          ReorderableListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(
                    key: Key("0"),
                  );
                }
                final feature =
                    global.allFeatures[global.favouriteFeatures[index]];
                return FeatureTile(
                  feature: feature!,
                  key: Key("$index"),
                  isFavourite: true,
                  enabled: true,
                  index: index,
                  favouriteCallback: () {
                    setState(() {
                      global.homeFeatures
                          .add(global.favouriteFeatures.removeAt(index));
                      global.saveFeatureData();
                    });
                  },
                  disableCallback: () {
                    setState(() {
                      global.favouriteFeatures.removeAt(index);
                      global.saveFeatureData();
                    });
                  },
                );
              },
              itemCount: global.favouriteFeatures.length,
              onReorder: (from, to) {
                if (from == 0 || to == 0) {
                  return;
                }
                if (to == global.favouriteFeatures.length) {
                  to--;
                }
                setState(() {
                  global.favouriteFeatures
                      .insert(to, global.favouriteFeatures.removeAt(from));
                  global.saveFeatureData();
                });
              }),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Home",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
            ),
          ),
          ReorderableListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(
                    key: Key("0"),
                  );
                }
                final feature = global.allFeatures[global.homeFeatures[index]];
                return FeatureTile(
                  feature: feature!,
                  key: Key("$index"),
                  index: index,
                  enabled: true,
                  isFavourite: false,
                  disableCallback: () {
                    setState(() {
                      global.homeFeatures.removeAt(index);
                      global.saveFeatureData();
                    });
                  },
                  favouriteCallback: () {
                    setState(() {
                      global.favouriteFeatures
                          .add(global.homeFeatures.removeAt(index));
                      global.saveFeatureData();
                    });
                  },
                );
              },
              itemCount: global.homeFeatures.length,
              onReorder: (from, to) {
                if (from == 0 || to == 0) {
                  return;
                }
                if (to == global.homeFeatures.length) {
                  to--;
                }
                setState(() {
                  global.homeFeatures
                      .insert(to, global.homeFeatures.removeAt(from));
                  global.saveFeatureData();
                });
              }),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Disabled",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: disabled.length,
            itemBuilder: (context, index) {
              return FeatureTile(
                  feature: global.allFeatures[disabled[index]]!,
                  index: index,
                  isFavourite: false,
                  enabled: false,
                  favouriteCallback: () {},
                  disableCallback: () {
                    setState(() {
                      global.homeFeatures.add(disabled[index]);
                      global.saveFeatureData();
                    });
                  });
            },
          )
        ],
      ),
    );
  }
}

class FeatureTile extends StatefulWidget {
  final Feature feature;
  final Function favouriteCallback;
  final Function disableCallback;
  final bool isFavourite;
  final bool enabled;
  final int index;

  const FeatureTile({
    Key? key,
    required this.feature,
    required this.index,
    required this.isFavourite,
    required this.enabled,
    required this.favouriteCallback,
    required this.disableCallback,
  }) : super(key: key);

  @override
  _FeatureTileState createState() => _FeatureTileState();
}

class _FeatureTileState extends State<FeatureTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        textColor: Colors.black,
        iconColor: Colors.black,
        title: Text(widget.feature.name),
        tileColor: widget.enabled ? Colors.blue.shade50 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: const Icon(Icons.table_rows_rounded),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            !widget.enabled
                ? const SizedBox()
                : IconButton(
                    color: Colors.red,
                    icon: Icon(widget.isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded),
                    onPressed: () {
                      widget.favouriteCallback();
                    },
                  ),
            TextButton(
                onPressed: () => widget.disableCallback(),
                child: Text(widget.enabled ? "Disable" : "Enable")),
          ],
        ),
      ),
    );
  }
}
