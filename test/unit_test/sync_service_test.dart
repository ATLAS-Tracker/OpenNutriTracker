import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_nutriments_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_or_recipe_dbo.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/services/sync/sync_action.dart';
import 'package:opennutritracker/services/sync/sync_processor_service.dart';
import 'package:opennutritracker/services/sync/sync_queue_service.dart';

import '../fixture/meal_entity_fixtures.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DummySupabaseClient extends Mock implements SupabaseClient {}

class FakeConnectivity extends Fake implements Connectivity {
  final _controller = StreamController<ConnectivityResult>.broadcast();
  ConnectivityResult _result = ConnectivityResult.none;

  @override
  Future<ConnectivityResult> checkConnectivity() async => _result;

  @override
  Stream<ConnectivityResult> get onConnectivityChanged => _controller.stream;

  void setResult(ConnectivityResult result) {
    _result = result;
    _controller.add(result);
  }

  void dispose() {
    _controller.close();
  }
}

class TestSyncProcessorService extends SyncProcessorService {
  int called = 0;
  TestSyncProcessorService(Box<SyncAction> box, Connectivity connectivity)
      : super(box, DummySupabaseClient(), connectivity);

  @override
  Future<void> processQueue() async {
    called++;
    // Do not call super to avoid network logic
  }
}

void main() {
  group('SyncQueueService', () {
    late Directory tempDir;
    late Box<IntakeDBO> intakeBox;
    late Box<SyncAction> queueBox;
    late SyncQueueService service;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      tempDir = await Directory.systemTemp.createTemp('hive_sync_test');
      Hive.init(tempDir.path);
      Hive.registerAdapter(IntakeDBOAdapter());
      Hive.registerAdapter(IntakeTypeDBOAdapter());
      Hive.registerAdapter(MealDBOAdapter());
      Hive.registerAdapter(MealSourceDBOAdapter());
      Hive.registerAdapter(MealNutrimentsDBOAdapter());
      Hive.registerAdapter(MealOrRecipeDBOAdapter());
      if (!Hive.isAdapterRegistered(18)) {
        Hive.registerAdapter(SyncActionAdapter());
      }

      intakeBox = await Hive.openBox<IntakeDBO>('intakes');
      queueBox = await Hive.openBox<SyncAction>('queue');
      service = SyncQueueService(intakeBox, queueBox);
      await service.start();
    });

    tearDown(() async {
      await service.dispose();
      await intakeBox.close();
      await queueBox.close();
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('queues create, update and delete actions', () async {
      final meal = MealEntityFixtures.mealOne;
      final intakeEntity = IntakeEntity(
        id: '1',
        unit: 'g',
        amount: 100,
        type: IntakeTypeEntity.breakfast,
        meal: meal,
        dateTime: DateTime.now(),
      );
      final intake = IntakeDBO.fromIntakeEntity(intakeEntity);

      await intakeBox.add(intake);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(queueBox.length, 1);
      final create = queueBox.getAt(0)!;
      expect(create.action, 'create');
      expect(create.data!['id'], '1');

      final updatedEntity = intakeEntity.copyWith(amount: 200);
      final updated = IntakeDBO.fromIntakeEntity(updatedEntity);
      await intakeBox.putAt(0, updated);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(queueBox.length, 2);
      final update = queueBox.getAt(1)!;
      expect(update.action, 'update');
      expect(update.data!['amount'], 200);

      await intakeBox.deleteAt(0);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(queueBox.length, 3);
      final delete = queueBox.getAt(2)!;
      expect(delete.action, 'delete');
      expect(delete.data, isNull);
      expect(delete.id, '1');
    });
  });

  test('SyncProcessorService processes on connectivity change', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final tempDir = await Directory.systemTemp.createTemp('hive_proc_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(18)) {
      Hive.registerAdapter(SyncActionAdapter());
    }
    final queueBox = await Hive.openBox<SyncAction>('queue');

    final connectivity = FakeConnectivity();
    final service = TestSyncProcessorService(queueBox, connectivity);
    await service.start();

    expect(service.called, 0);
    connectivity.setResult(ConnectivityResult.wifi);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(service.called, 1);

    await service.dispose();
    connectivity.dispose();
    await queueBox.close();
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });
}
