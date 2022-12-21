import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/note_use_cases.dart';
import '../../bloc/add_note/add_note_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteUseCases noteUseCases;

  StreamSubscription? streamSubscription;
  final AddNoteBloc addNoteBloc;

  final List<Note> _notes = [];
  HomeCubit({required this.noteUseCases, required this.addNoteBloc})
      : super(const GetNoteSuccessfulState()) {
    _onStart();
  }

  _onStart() {
    streamSubscription?.cancel();
    streamSubscription = addNoteBloc.stream.listen(
      (addNoteBlocState) {
        if (addNoteBlocState is NoteAddedSuccessfulState) {
          _notes.add(addNoteBlocState.note);
          emit(
            (state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  Future<void> getNotes() async {
    emit(const GetNoteSuccessfulState());
    final either = await noteUseCases.getNotesUseCase();
    either.fold(
      (failure) => emit(GetNoteErrorState(message: failure.message)),
      (notes) {
        print('Note-- ${notes.length}');
        _notes.addAll(notes);
        emit(
          (state as GetNoteSuccessfulState).copyWith(notes: _notes.toList()),
        );
      },
    );
  }
}
