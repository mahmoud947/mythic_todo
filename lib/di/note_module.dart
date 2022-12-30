import '../features/note/domain/usecases/delete_note_use_case.dart';

import '../core/platform/worker/note_work_manager.dart';
import '../features/note/data/data_sources/remote/remote_data_source.dart';
import '../features/note/data/data_sources/remote/remote_data_source_impl_with_firebase.dart';

import '../features/note/domain/usecases/delete_all_note_use_case.dart';

import 'app_module.dart';
import '../features/note/data/data_sources/local/note_dao.dart';
import '../features/note/data/data_sources/local/note_dao_impl.dart';
import '../features/note/data/repositories/note_repository_impl.dart';
import '../features/note/domain/repositories/note_repository.dart';
import '../features/note/domain/usecases/get_note_use_case.dart';
import '../features/note/domain/usecases/get_notes_use_case.dart';
import '../features/note/domain/usecases/insert_note_use_case.dart';
import '../features/note/domain/usecases/note_use_cases.dart';
import '../features/note/domain/usecases/validation/note_title_validation_use_case.dart';
import '../features/note/presentation/bloc/add_note/add_note_bloc.dart';
import '../features/note/presentation/cubit/home/home_cubit.dart';

import 'package:sqflite/sqflite.dart';

initNoteModule() {
//! Bloc && Cubit

//? ...HomeCubit
  ls.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      noteUseCases: ls(),
      addNoteBloc: ls<AddNoteBloc>(),
    ),
  );

//? ...AddNoteBloc
  ls.registerLazySingleton<AddNoteBloc>(
    () => AddNoteBloc(
      noteTitleValidationUseCase: ls(),
      noteUseCases: ls(),
    ),
  );

//! UseCases
//? ...provide all usecases with singltone pattern
  ls.registerFactory<NoteUseCases>(
    () => NoteUseCases(
      getNoteUseCase: GetNoteUseCase(repository: ls()),
      insertNoteUseCase: InsertNoteUseCase(repository: ls()),
      getNotesUseCase: GetNotesUseCase(repository: ls()),
      deleteAllNoteUseCase: DeleteAllNoteUseCase(repository: ls()),
      deleteNoteUseCase: DeleteNoteUseCase(repository: ls()),
    ),
  );

//? ...provide validation usecases with singltone pattern
  ls.registerLazySingleton<NoteTitleValidationUseCase>(
      () => NoteTitleValidationUseCase());

//! Repository
//? ..note repository

  ls.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      noteDao: ls(),
      remoteDataSource: ls(),
      workmanager: NoteWorkManagerImpl(),
    ),
  );

//! Datasources
//? ...local data source
  ls.registerLazySingleton<NoteDao>(
      () => NoteDaoImpl(database: ls<Database>()));

//? ...remote data source
  ls.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplWithFirebase());

//
}
