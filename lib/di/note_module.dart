import 'package:mythic_todo/di/app_module.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao_impl.dart';
import 'package:mythic_todo/features/note/data/repositories/note_repository_impl.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';
import 'package:mythic_todo/features/note/domain/usecases/get_note_use_case.dart';
import 'package:mythic_todo/features/note/domain/usecases/get_notes_use_case.dart';
import 'package:mythic_todo/features/note/domain/usecases/insert_note_use_case.dart';
import 'package:mythic_todo/features/note/domain/usecases/note_use_cases.dart';
import 'package:mythic_todo/features/note/domain/usecases/validation/note_title_validation_use_case.dart';
import 'package:mythic_todo/features/note/presentation/bloc/add_note/add_note_bloc.dart';
import 'package:mythic_todo/features/note/presentation/bloc/home/home_bloc.dart';

import 'package:sqflite/sqflite.dart';

initNoteModule() {
//! Bloc && Cubit

//? ...HomeBloc
  ls.registerFactory<HomeBloc>(() => HomeBloc(noteUseCases: ls()));

//? ...AddNoteBloc
  ls.registerFactory<AddNoteBloc>(
      () => AddNoteBloc(noteTitleValidationUseCase: ls()));

//! UseCases
//? ...provide all usecases with singltone pattern
  ls.registerLazySingleton<NoteUseCases>(
    () => NoteUseCases(
        getNoteUseCase: GetNoteUseCase(repository: ls()),
        insertNoteUseCase: InsertNoteUseCase(repository: ls()),
        getNotesUseCase: GetNotesUseCase(repository: ls())),
  );

//? ...provide validation usecases with singltone pattern
  ls.registerLazySingleton<NoteTitleValidationUseCase>(
      () => NoteTitleValidationUseCase());

//! Repository
//? ..note repository

  ls.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(noteDao: ls()),
  );

//! Datasources
//? ...local data source
  ls.registerLazySingleton<NoteDao>(
      () => NoteDaoImpl(database: ls<Database>()));
}
