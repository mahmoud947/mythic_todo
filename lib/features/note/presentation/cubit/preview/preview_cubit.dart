import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/usecases/note_use_cases.dart';

part 'preview_state.dart';

class PreviewCubit extends Cubit<PreviewState> {
  final NoteUseCases noteUseCases;

  PreviewCubit({required this.noteUseCases}) : super(PreviewInitial());

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
}
