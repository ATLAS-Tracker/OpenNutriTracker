import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_if_remote_newer_usecase.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_data_supabase_usecase.dart';
import 'package:opennutritracker/features/settings/presentation/bloc/export_import_bloc.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockStorageClient extends Mock implements SupabaseStorageClient {}

class MockStorageFileApi extends Mock implements StorageFileApi {}

class MockAuthClient extends Mock implements GoTrueClient {}

class MockImportDataSupabaseUsecase extends Mock
    implements ImportDataSupabaseUsecase {}

class MockConfigRepository extends Mock implements ConfigRepository {}

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
    late MockConfigRepository configRepo;
    late ImportIfRemoteNewerUsecase usecase;

    setUp(() {
      client = MockSupabaseClient();
      storage = MockStorageClient();
      bucket = MockStorageFileApi();
      auth = MockAuthClient();
      importUsecase = MockImportDataSupabaseUsecase();
      configRepo = MockConfigRepository();

      when(() => client.storage).thenReturn(storage);
      when(() => storage.from('exports')).thenReturn(bucket);
      when(() => client.auth).thenReturn(auth);
      usecase = ImportIfRemoteNewerUsecase(
        client,
        importUsecase,
        configRepo,
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
      when(() => configRepo.getLastDataUpdate())
          .thenAnswer((_) async => localDate);
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
      when(() => configRepo.getLastDataUpdate())
          .thenAnswer((_) async => localDate);

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
