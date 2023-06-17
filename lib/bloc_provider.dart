import "dart:developer";
import "package:flutter/widgets.dart";
import "timeline/entry.dart";
import 'timeline/timeline.dart';


/// This [InheritedWidget] wraps the whole app, and provides access
/// to the [Distance] object.
class BlocProvider extends InheritedWidget {
  final Timeline timeline;

  BlocProvider(
      {Key? key,
        required Timeline t,
        required Widget child,
        TargetPlatform platform = TargetPlatform.iOS})
      : timeline = t ?? Timeline(platform),
        super(key: key, child: child) {
    timeline
        .loadFromBundle("assets/distance.json")
        .then((List<TimelineEntry> entries) {
      timeline.setViewport(
          start: entries.first.start * 2.0,
          end: entries.first.start,
          animate: true);

      /// Advance the distance to its starting position.
      timeline.advance(0.0, false);
    });
  }

  @override
  updateShouldNotify(InheritedWidget oldWidget) => true;

  /// static accessor for the [Distance].
  /// e.g. [_MainMenuWidgetState.navigateToDistance] uses this static getter to access build the [DistanceWidget].
  static Timeline getTimeline(BuildContext context) {
    BlocProvider? bp =
    context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    Timeline bloc = bp!.timeline;
    return bloc;
  }
}
