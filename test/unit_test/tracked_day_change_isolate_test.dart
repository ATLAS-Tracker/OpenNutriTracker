import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/features/sync/tracked_day_change_isolate.dart';

void main() {
  group('TrackedDayChangeIsolate', () {
    late Directory tempDir;
    late Box<TrackedDayDBO> box;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      tempDir = await Directory.systemTemp.createTemp('hive_test_isolate_');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(9)) {
        Hive.registerAdapter(TrackedDayDBOAdapter());
      }
      box = await Hive.openBox<TrackedDayDBO>('tracked_day_test');
      await TrackedDayChangeIsolate.start(box);
    });

    tearDown(() async {
      await TrackedDayChangeIsolate.stop();
      await box.close();
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('captures modified day when box updates', () async {
      final day = DateTime.utc(2024, 1, 1);
      await box.put('d1', TrackedDayDBO(day: day, calorieGoal: 0, caloriesTracked: 0));

      // give some time for the isolate to process the event
      await Future.delayed(const Duration(milliseconds: 100));

      final modified = await TrackedDayChangeIsolate.getModifiedDays();
      expect(modified, contains(day));
    });

    test('stores unique days when multiple updates occur', () async {
      final day1 = DateTime.utc(2024, 1, 1);
      final day2 = DateTime.utc(2024, 1, 2);

      await box.put('d1', TrackedDayDBO(day: day1, calorieGoal: 0, caloriesTracked: 0));
      await box.put('d2', TrackedDayDBO(day: day2, calorieGoal: 0, caloriesTracked: 0));
      await box.put('d1', TrackedDayDBO(day: day1, calorieGoal: 1, caloriesTracked: 0));

      await Future.delayed(const Duration(milliseconds: 100));

      final modified = await TrackedDayChangeIsolate.getModifiedDays();
      expect(modified.toSet(), {day1, day2});
    });
  });
}
