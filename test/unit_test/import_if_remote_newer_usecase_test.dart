import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_if_remote_newer_usecase.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_data_supabase_usecase.dart';
import 'package:opennutritracker/features/settings/presentation/bloc/export_import_bloc.dart';
import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:opennutritracker/core/data/repository/tracked_day_repository.dart';
import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';
import 'package:opennutritracker/core/data/data_source/user_weight_dbo.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockStorageClient extends Mock implements SupabaseStorageClient {}

class MockStorageFileApi extends Mock implements StorageFileApi {}

class MockAuthClient extends Mock implements GoTrueClient {}

class MockImportDataSupabaseUsecase extends Mock
    implements ImportDataSupabaseUsecase {}

class MockIntakeRepository extends Mock implements IntakeRepository {}

class MockUserActivityRepository extends Mock implements UserActivityRepository {}

class MockTrackedDayRepository extends Mock implements TrackedDayRepository {}

class MockUserWeightRepository extends Mock implements UserWeightRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const SearchOptions());
  });

  group('ImportIfRemoteNewerUsecase', () {
    late MockSupabaseClient client;
    late MockStorageClient storage;
    late MockStorageFileApi bucket;
    late MockAuthClient auth;
    late MockImportDataSupabaseUsecase importUsecase;
    late MockIntakeRepository intakeRepo;
    late MockUserActivityRepository activityRepo;
    late MockTrackedDayRepository trackedRepo;
    late MockUserWeightRepository weightRepo;
    late ImportIfRemoteNewerUsecase usecase;

    setUp(() {
      client = MockSupabaseClient();
      storage = MockStorageClient();
      bucket = MockStorageFileApi();
      auth = MockAuthClient();
      importUsecase = MockImportDataSupabaseUsecase();
      intakeRepo = MockIntakeRepository();
      activityRepo = MockUserActivityRepository();
      trackedRepo = MockTrackedDayRepository();
      weightRepo = MockUserWeightRepository();

      when(() => client.storage).thenReturn(storage);
      when(() => storage.from('exports')).thenReturn(bucket);
      when(() => client.auth).thenReturn(auth);
      when(() => intakeRepo.getAllIntakesDBO()).thenAnswer((_) async => []);
      when(() => activityRepo.getAllUserActivityDBO()).thenAnswer((_) async => []);
      when(() => trackedRepo.getAllTrackedDaysDBO()).thenAnswer((_) async => []);

      usecase = ImportIfRemoteNewerUsecase(
        client,
        importUsecase,
        intakeRepo,
        activityRepo,
        trackedRepo,
        weightRepo,
      );
    });

    test('imports when remote timestamp is newer', () async {
      final remoteDate = DateTime.utc(2024, 2, 1);
      final file = FileObject(
        name: ExportImportBloc.exportZipFileName,
        bucketId: 'exports',
        owner: 'user1',
        id: '1',
        updatedAt: remoteDate.toIso8601String(),
        createdAt: remoteDate.toIso8601String(),
        lastAccessedAt: remoteDate.toIso8601String(),
        metadata: const {},
        buckets: const Bucket(
          id: 'b',
          name: 'n',
          owner: 'o',
          createdAt: '',
          updatedAt: '',
          public: false,
        ),
      );
      when(() => bucket.list(path: 'user1', searchOptions: any(named: 'searchOptions')))
          .thenAnswer((_) async => [file]);
      when(() => auth.currentUser).thenReturn(const User(
        id: 'user1',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: '',
      ));
      final localDate = DateTime.utc(2024, 1, 1);
      when(() => weightRepo.getAllUserWeightDBOs())
          .thenAnswer((_) async => [UserWeightDbo('1', 1, localDate, localDate)]);
      when(() => importUsecase.importData(any(), any(), any(), any(), any()))
          .thenAnswer((_) async => true);

      await usecase.maybeImport(
        ExportImportBloc.exportZipFileName,
        ExportImportBloc.userActivityJsonFileName,
        ExportImportBloc.userIntakeJsonFileName,
        ExportImportBloc.trackedDayJsonFileName,
        ExportImportBloc.userWeightJsonFileName,
      );

      verify(() => importUsecase.importData(
            ExportImportBloc.exportZipFileName,
            ExportImportBloc.userActivityJsonFileName,
            ExportImportBloc.userIntakeJsonFileName,
            ExportImportBloc.trackedDayJsonFileName,
            ExportImportBloc.userWeightJsonFileName,
          )).called(1);
    });

    test('skips import when remote timestamp is older', () async {
      final remoteDate = DateTime.utc(2023, 1, 1);
      final file = FileObject(
        name: ExportImportBloc.exportZipFileName,
        bucketId: 'exports',
        owner: 'user1',
        id: '1',
        updatedAt: remoteDate.toIso8601String(),
        createdAt: remoteDate.toIso8601String(),
        lastAccessedAt: remoteDate.toIso8601String(),
        metadata: const {},
        buckets: const Bucket(
          id: 'b',
          name: 'n',
          owner: 'o',
          createdAt: '',
          updatedAt: '',
          public: false,
        ),
      );
      when(() => bucket.list(path: 'user1', searchOptions: any(named: 'searchOptions')))
          .thenAnswer((_) async => [file]);
      when(() => auth.currentUser).thenReturn(const User(
        id: 'user1',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: '',
      ));
      final localDate = DateTime.utc(2024, 1, 1);
      when(() => weightRepo.getAllUserWeightDBOs())
          .thenAnswer((_) async => [UserWeightDbo('1', 1, localDate, localDate)]);

      await usecase.maybeImport(
        ExportImportBloc.exportZipFileName,
        ExportImportBloc.userActivityJsonFileName,
        ExportImportBloc.userIntakeJsonFileName,
        ExportImportBloc.trackedDayJsonFileName,
        ExportImportBloc.userWeightJsonFileName,
      );

      verifyNever(() => importUsecase.importData(any(), any(), any(), any(), any()));
    });
  });
}
