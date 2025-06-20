import 'dart:io';
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/features/sync/tracked_day_change_isolate.dart';
import 'package:opennutritracker/features/sync/supabase_client.dart';

class MockTrackedDayService extends Mock implements SupabaseTrackedDayService {}

class FakeConnectivity extends Mock implements Connectivity {
  final _controller = StreamController<ConnectivityResult>.broadcast();
  ConnectivityResult _result = ConnectivityResult.none;

  @override
  Stream<ConnectivityResult> get onConnectivityChanged => _controller.stream;

  @override
  Future<ConnectivityResult> checkConnectivity() async => _result;

  void emit(ConnectivityResult result) {
    _result = result;
    _controller.add(result);
  }

  Future<void> close() async {
    await _controller.close();
  }
}

Future<void> waitForCondition(
  Future<bool> Function() condition, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    if (await condition()) return;
    await Future.delayed(const Duration(milliseconds: 10));
  }
  throw TimeoutException('Condition not met within $timeout');
}


void main() {
  group('TrackedDayChangeIsolate', () {
    late Directory tempDir;
    late Box<TrackedDayDBO> box;
    late TrackedDayChangeIsolate watcher;
    late MockTrackedDayService service;
    late FakeConnectivity connectivity;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      tempDir = await Directory.systemTemp.createTemp('hive_test_isolate_');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(trackedDayDBOTypeId)) {
        Hive.registerAdapter(TrackedDayDBOAdapter());
      }
      box = await Hive.openBox<TrackedDayDBO>('tracked_day_test');
      service = MockTrackedDayService();
      connectivity = FakeConnectivity();
      watcher = TrackedDayChangeIsolate(
        box,
        service: service,
        connectivity: connectivity,
      );
      await watcher.start();
    });

    tearDown(() async {
      await watcher.stop();
      await connectivity.close();
      await box.close();
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('captures modified day when box updates', () async {
      final day = DateTime.utc(2024, 1, 1);
      await box.put('d1', TrackedDayDBO(day: day, calorieGoal: 0, caloriesTracked: 0));


      await waitForCondition(() async => (await watcher.getModifiedDays()).contains(day));
    });

    test('stores unique days when multiple updates occur', () async {
      final day1 = DateTime.utc(2024, 1, 1);
      final day2 = DateTime.utc(2024, 1, 2);

      await box.put('d1', TrackedDayDBO(day: day1, calorieGoal: 0, caloriesTracked: 0));
      await box.put('d2', TrackedDayDBO(day: day2, calorieGoal: 0, caloriesTracked: 0));
      await box.put('d1', TrackedDayDBO(day: day1, calorieGoal: 1, caloriesTracked: 0));

      await waitForCondition(() async => (await watcher.getModifiedDays()).length >= 2);

      final modified = await watcher.getModifiedDays();
      expect(modified.toSet(), {day1, day2});
    });

    test('syncs modified days when connectivity is restored', () async {
      final day = DateTime.utc(2024, 1, 3);
      final dbo =
          TrackedDayDBO(day: day, calorieGoal: 1, caloriesTracked: 0);

      when(() => service.upsertTrackedDays(any<List<Map<String, dynamic>>>()))
          .thenAnswer((_) async {});

      await box.put('d1', dbo);

      await waitForCondition(() async => (await watcher.getModifiedDays()).isNotEmpty);

      connectivity.emit(ConnectivityResult.wifi);

      await waitForCondition(() async => (await watcher.getModifiedDays()).isEmpty);

    });
  });
}
