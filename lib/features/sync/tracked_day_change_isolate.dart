import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/features/sync/change_isolate.dart';

/// Watches a [TrackedDayDBO] box and collects modified day values in a
/// background isolate.
class TrackedDayChangeIsolate extends ChangeIsolate<DateTime> {
  TrackedDayChangeIsolate(Box<TrackedDayDBO> box)
      : super(
          box: box,
          extractor: (event) {
            final value = event.value;
            if (value is TrackedDayDBO) {
              return value.day;
            }
            return null;
          },
        );

  /// Convenience method that forwards to [getItems].
  Future<List<DateTime>> getModifiedDays() => getItems();
}
