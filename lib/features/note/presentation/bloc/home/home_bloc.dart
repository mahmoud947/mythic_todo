import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mythic_todo/features/note/data/mapper/mapper.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';
import 'package:mythic_todo/features/note/domain/usecases/note_use_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NoteUseCases noteUseCases;
  List<Note> _notes = [];
  HomeBloc({required this.noteUseCases}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetAllNotesEvent>((event, emit) => _getNotes(event, emit));
    on<InsertNoteEvent>((event, emit) => _insertNote(event, emit));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  _getNotes(GetAllNotesEvent event, Emitter<HomeState> emit) async {
    final either = await noteUseCases.getNotesUseCase();
    either.fold(
      (failure) => emit(GetNoteErrorState(message: failure.message)),
      (notes) {
        _notes.clear();
        _notes.addAll(notes);
        emit(GetNoteSuccessfulState(notes: notes));
      },
    );
  }

  _insertNote(InsertNoteEvent event, Emitter<HomeState> emit) async {
    final either = await noteUseCases.insertNoteUseCase(input: event.note);
    either.fold(
      (failure) => emit(GetNoteErrorState(message: failure.message)),
      (_) {
        emit(InsertNoteSuccessfulState());
        _notes.add(event.note.toDomain());
        emit(GetNoteSuccessfulState(notes: _notes));
      },
    );
  }
}
