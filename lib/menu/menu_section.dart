import 'package:flutter/material.dart';
import 'menu_data.dart';

typedef NavigateTo = Function(MenuItemData item);

/// This widget displays the single menu section of the [MainMenuWidget].
///
/// There are main sections, as loaded from the menu.json file in the　assets folder.
/// Each section has a backgroundColor,
/// and a list of elements it needs to display when expanded.
///
/// Since this widget expands and contracts when tapped, it needs to maintain a [State].
class MenuSection extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color accentColor;
  final List<MenuItemData> menuOptions;
  final NavigateTo navigateTo;

  const MenuSection(this.title, this.backgroundColor, this.accentColor,
      this.menuOptions, this.navigateTo,
      {Key? key}) : super(key: key);

  /// This method wraps the whole widget in a [GestureDetector] to handle taps appropriately.
  ///
  /// A custom [BoxDecoration] is used to render the rounded rectangle on the screen,
  ///
  /// The [SizeTransition] opens up the section and displays the list underneath the section title.
  ///
  /// Each section sub-element is wrapped into a [GestureDetector] too so that the Timeline can be displayed
  /// when that element is tapped.
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
     ListTile(
       title: Text(
         title,
         style: TextStyle(
           fontSize: 20.0,
           color: accentColor,
         ),
       ),
     ),
      SingleChildScrollView(
          child: Column(
            children: menuOptions.map<Widget>((item) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      tileColor: backgroundColor,
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    title: Text(
                    item.label,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 16.0,
                      ),
                    ),
                    onTap: () => navigateTo(item),
                  ),
              );
            }).toList(),
          ),
      ),
    ],
    );
  }
}
