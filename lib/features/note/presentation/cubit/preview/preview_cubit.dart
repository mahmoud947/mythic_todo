import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/add_note/add_note_bloc.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/usecases/note_use_cases.dart';

part 'preview_state.dart';

class PreviewCubit extends Cubit<PreviewState> {
  final NoteUseCases noteUseCases;
  final AddNoteBloc addNoteBloc;
  StreamSubscription? _streamSubscription;

  PreviewCubit({required this.noteUseCases, required this.addNoteBloc})
      : super(PreviewInitial()) {
    _onStart();
  }

  void _onStart() {
    _streamSubscription?.cancel();
    _streamSubscription = addNoteBloc.stream.listen((event) {
      if (event is NoteUpdatedSuccessfulState) {
        emit(PreviewSuccessState(note: event.note));
      }
    });
  }

  Future<void> getNote({required String noteId}) async {
    emit(PreviewLoadingState());
    final either = await noteUseCases.getNoteUseCase(input: noteId);
    either.fold(
        (failure) => emit(
              PreviewErrorState(message: failure.message),
            ),
        (note) => emit(
              PreviewSuccessState(note: note),
            ));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
