import 'dart:ui' as ui;
import 'dart:ui';

/// An object representing the renderable assets loaded from `timeline.json`.
///
/// Each [TimelineAsset] encapsulates all the relevant properties for drawing,
/// as well as maintaining a reference to its original [TimelineEntry].
class TimelineAsset {
  double width;
  double height;
  double opacity = 0.0;
  double scale = 0.0;
  double scaleVelocity = 0.0;
  double y = 0.0;
  double velocity = 0.0;
  TimelineEntry entry;
}

/// A renderable image.
class TimelineImage extends TimelineAsset {
  ui.Image image;
}

/// A label for [TimelineEntry].
enum TimelineEntryType { position, material }

/// Each entry in the Timeline is represented by an instance of this object.
/// Each favorite, search result and detail page will grab the information from a reference
/// to this object.
///
/// They are all initialized at startup time by the [BlocProvider] constructor.
class TimelineEntry {
  TimelineEntryType type;

  /// Used to calculate how many lines to draw for the bubble in the Timeline.
  int lineCount = 1;

  String _label;
  Color accent;

  /// Each entry constitues an element of a tree:
  /// positions are grouped into spanning positions and events are placed into the positions they belong to.
  TimelineEntry parent;
  List<TimelineEntry> children;

  /// All the Timeline entries are also linked together to easily access the next/previous element.
  /// After a couple of seconds of inactivity on the Timeline, a previous/next entry button will appear
  /// to allow the user to navigate faster between adjacent element.
  TimelineEntry next;
  TimelineEntry previous;

  /// All these parameters are used by the [Timeline] object to properly position the current entry.
  double start;
  double end;
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

  String get label => _label;

  /// Some labels already have newline characters to adjust their alignment.
  /// Detect the occurrence and add information regarding the line-count.
  set label(String value) {
    _label = value;
    int start = 0;
    lineCount = 1;
    while (true) {
      start = _label.indexOf("\n", start);
      if (start == -1) {
        break;
      }
      lineCount++;
      start++;
    }
  }

  /// Pretty-printing for the entry position.
  /// 前のobjectまでの距離を表示
  String formatFarAway() {
    if (start > 0) {
      return start.round().toString();
    }
    return TimelineEntry.formatTimeline(start);
  }

  /// Debug information.
  @override
  String toString() {
    return "Timeline ENTRY: $label -($start,$end)";
  }

  /// Helper method.
  /// object間の距離を算出
  ///メモリ表示と等しい10cm単位
  static String formatTimeline(double start) {
    String label;
    int valueAbs = start.round().abs();
    if (valueAbs > 1000000000) {
      double v = (valueAbs / 100000000.0).floorToDouble() / 10.0;

      label = "${(valueAbs / 1000000000)
          .toStringAsFixed(v == v.floorToDouble() ? 0 : 1)} Billion";
    } else if (valueAbs > 1000000) {
      double v = (valueAbs / 100000.0).floorToDouble() / 10.0;
      label =
      "${(valueAbs / 1000000).toStringAsFixed(v == v.floorToDouble() ? 0 : 1)} Million";
    } else if (valueAbs > 10000) // N.B. < 10,000
        {
      double v = (valueAbs / 100.0).floorToDouble() / 10.0;
      label =
      "${(valueAbs / 1000).toStringAsFixed(v == v.floorToDouble() ? 0 : 1)} Thousand";
    } else {
      label = valueAbs.toStringAsFixed(0);
    }
    return "$label decimetres";
  }
}