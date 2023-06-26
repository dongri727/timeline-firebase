import "package:flutter/material.dart";

import "../bloc_provider.dart";
import "../timeline/widget.dart";
import "../ttf_format.dart";
import "menu_data.dart";
import "menu_section.dart";

/// The Base Page of the Timeline App.

class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({Key? key}) : super(key: key);

  @override
  MainMenuWidgetState createState() => MainMenuWidgetState();
}

class MainMenuWidgetState extends State<MainMenuWidget> {

  /// [MenuData] selects era witch will be displayed at the Timeline
  /// This data is loaded from the asset bundle during [initState()]
  final MenuData _menu = MenuData();


  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], this widget will know where to scroll to.
  navigateToTimeline(MenuItemData item) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) =>
          TimelineWidget(item, BlocProvider.getTimeline(context)),
    ));
  }

  @override
  initState() {
    super.initState();

    /// The [_menu] loads a JSON file that's stored in the assets folder.
    /// This asset provides all the necessary information.
    _menu.loadFromBundle("assets/menu.json").then((bool success) {
      if (success) setState(() {}); // Load the menu.
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    final controller = TextEditingController();
    final timeline = BlocProvider.getTimeline(context);

    List<Widget> tail = [];

    tail
        .addAll(_menu.sections
        .map<Widget>((MenuSectionData section) => Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: MenuSection(
          section.label,
          section.backgroundColor,
          section.textColor,
          section.items,
          navigateToTimeline,
        )))
        .toList(growable: false)
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("TIMELINE"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: devicePadding.top),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,5,20),
                        child: FormatGrey(
                          controller: controller,
                          hintText: "Search Term",
                          onChanged: (text) {
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5,20,20,20),
                        child: ElevatedButton(
                          onPressed: () {
                            timeline.loadFromFirestore('events', country: controller.text.isNotEmpty
                            ? controller.text
                            : null);

                            showDialog(
                              barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: const Text('Successfully Selected'),
                                    content: const Text('Choose an Era and Move On'),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('OK')),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(Icons.done),
                        ),),
                    )
                  ],
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: (){
                        controller.clear();
                        timeline.loadFromFirestore('events',country: null);
                      },
                      child: Text('clear')),
                )
              ] + tail),
        ),
      );
  }
}