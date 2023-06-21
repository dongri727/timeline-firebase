import 'package:flutter/material.dart';

/// A label for [TimelineEntry].
/// なんだかわからないけど消すとまずい
enum TimelineEntryType { era, incident }

/// Each entry in the Timeline is represented by an instance of this object.
/// They are all initialized at startup time by the [BlocProvider] constructor.
class TimelineEntry {
  late TimelineEntryType type;

  late String _name;
  Color accent = Colors.blueGrey;

  /// Each entry constitues an element of a tree:
  /// Eras are grouped into spanning positions and events are placed into the positions they belong to.
  TimelineEntry? parent;
  List<TimelineEntry> children = [];

  /// All the Timeline entries are also linked together to easily access the next/previous element.
  /// After a couple of seconds of inactivity on the Timeline, a previous/next entry button will appear
  /// to allow the user to navigate faster between adjacent element.
  TimelineEntry? next;
  TimelineEntry? previous;

  /// All these parameters are used by the [Timeline] object to properly position the current entry.
  late double start;
  late double end;
  double y = 0.0;
  double endY = 0.0;
  double length = 0.0;
  double opacity = 0.0;
  double labelOpacity = 0.0;
  double targetLabelOpacity = 0.0;
  double delayLabel = 0.0;
  double legOpacity = 0.0;
  double labelY = 0.0;
  double labelVelocity = 0.0;

  bool get isVisible {
    return opacity > 0.0;
  }

  String get name => _name;

  /// Some labels already have newline characters to adjust their alignment.
  /// Detect the occurrence and add information regarding the line-count.
  set name(String value) {
    _name = value;
/*    int start = 0;
    while (true) {
      start = _name.indexOf("\n", start);
      if (start == -1) {
        break;
      }
      start++;
    }*/
  }
}