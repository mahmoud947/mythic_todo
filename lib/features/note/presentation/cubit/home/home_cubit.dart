import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/usecases/note_use_cases.dart';
import '../../bloc/add_note/add_note_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteUseCases noteUseCases;

  StreamSubscription? _streamSubscription;
  final AddNoteBloc addNoteBloc;

  final List<Note> _notes = [];

  HomeCubit({required this.noteUseCases, required this.addNoteBloc})
      : super(GetNoteSuccessfulState()) {
    _onStart();
  }

  _onStart() {
    _streamSubscription?.cancel();

    _streamSubscription = addNoteBloc.stream.listen(
      (addNoteBlocState) {
        if (addNoteBlocState is NoteAddedSuccessfulState) {
          _notes.insert(0, addNoteBlocState.note); // ! O(n)
          emit(
            (state as GetNoteSuccessfulState).copyWith(notes: _notes),
          );
        } else if (addNoteBlocState is NoteUpdatedSuccessfulState) {
          _notes.removeWhere(
              (note) => note.id == addNoteBlocState.note.id); //! O(n)
          _notes.insert(0, addNoteBlocState.note); // ! O(n)
          emit(
            (state as GetNoteSuccessfulState).copyWith(notes: _notes),
          );
        }
      },
    );
  }

  Future<void> getNotes() async {
    final either = await noteUseCases.getNotesUseCase();
    either.fold(
      (failure) {
        emit(
          (state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()),
        );
      },
      (notes) {
        _notes.addAll(notes);
        emit(
          (state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()),
        );
      },
    );
  }

  Future<void> deleteNote(Note note) async {
    final either = await noteUseCases.deleteNoteUseCase(input: note.id);
    either.fold(
      (failure) => {},
      (_) {
        _notes.remove(note);
        emit(
            (state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()));
      },
    );
  }

  Future<void> deleteAllNote() async {
    final either = await noteUseCases.deleteAllNoteUseCase();
    either.fold((failure) {}, (_) {
      _notes.clear();
      emit((state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
