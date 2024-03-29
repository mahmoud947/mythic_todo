import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/wrappers.dart';
import '../../../data/mapper/mapper.dart';
import '../../../data/models/note_model.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/note_use_cases.dart';
import '../../../domain/usecases/validation/note_title_validation_use_case.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteTitleValidationUseCase noteTitleValidationUseCase;
  final NoteUseCases noteUseCases;

  AddNoteBloc({
    required this.noteTitleValidationUseCase,
    required this.noteUseCases,
  }) : super(const AddNoteFormState()) {
    on<OnTitleChange>((event, emit) => _onTitleChange(event, emit));
    on<OnDescriptionChange>((event, emit) => _onDescriptionChange(event, emit));
    on<OnSubmitEvent>((event, emit) => _insertNote(event, emit));
    on<Clear>((event, emit) => _clear(emit));
    on<TogglePreview>((event, emit) => _togglePreview(emit));
    on<OnGetNoteToUpdate>((event, emit) => _onGetNoteToUpdate(event, emit));
  }

  _onTitleChange(OnTitleChange event, Emitter<AddNoteState> emit) async {
    final currentState = state as AddNoteFormState;
    final either = await noteTitleValidationUseCase(input: event.title);

    failureState(message) => currentState.copyWith(
          title: '',
          isAllInputValid: false,
          titleErrorMessage: NullableWrapped.value(message),
        );

    successState(input) => currentState.copyWith(
          title: input,
          titleErrorMessage: const NullableWrapped.value(null),
        );

    either.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  _onDescriptionChange(OnDescriptionChange event, Emitter<AddNoteState> emit) {
    final currentState = state as AddNoteFormState;
    emit(currentState.copyWith(description: event.description));
  }

  void _isAllInputValid(OnTitleChange event, Emitter<AddNoteState> emit) {
    final currentState = state as AddNoteFormState;
    final isAllInputValued = currentState.title.isNotEmpty;

    emit(currentState.copyWith(isAllInputValid: isAllInputValued));
  }

  void _insertNote(AddNoteEvent event, Emitter<AddNoteState> emit) async {
    final DateFormat dateFormat = DateFormat('yyyy/mm/dd hh-mm-ss');
    final time = dateFormat.format(DateTime.now());
    final currentState = state as AddNoteFormState;

    final NoteModel note = NoteModel(
        title: currentState.title,
        description: currentState.description,
        color: getRandomColor(),
        id: currentState.id ?? const Uuid().v1(),
        uuid: FirebaseAuth.instance.currentUser?.uid,
        isCompleted: true,
        reminder: true,
        startTime: time,
        endTime: time);
    final either = await noteUseCases.insertNoteUseCase(input: note);
    either.fold(
      (failure) {
        if (failure is RemoteDataSourceFailure) {
          emit(NoteAddedSuccessfulState(note: note.toDomain()));
          return;
        }
        emit(AddNoteErrorState(message: failure.message));
        emit(currentState);
      },
      (_) {
        if (currentState.isUpdated == true) {
          emit(NoteUpdatedSuccessfulState(note: note.toDomain()));
        } else {
          emit(NoteAddedSuccessfulState(note: note.toDomain()));
        }
      },
    );
  }

  NoteColor getRandomColor() {
    final int numberColor = Random().nextInt(6);

    switch (numberColor) {
      case 1:
        return NoteColor.babyBlue;
      case 2:
        return NoteColor.green;
      case 3:
        return NoteColor.orang;
      case 4:
        return NoteColor.pink;
      case 5:
        return NoteColor.yellow;
      default:
        return NoteColor.purple;
    }
  }

  _clear(Emitter<AddNoteState> emit) {
    //final currentState = state as AddNoteFormState;
    emit(const AddNoteFormState(
      title: '',
      id: null,
      description: '',
      titleErrorMessage: null,
      isAllInputValid: false,
      isPreview: false,
      isUpdated: false,
    ));
  }

  _togglePreview(Emitter<AddNoteState> emit) {
    final currentState = state as AddNoteFormState;
    emit(currentState.copyWith(isPreview: !currentState.isPreview));
  }

  @override
  Future<void> close() {
    print('add note closed');
    return super.close();
  }

  _onGetNoteToUpdate(
      OnGetNoteToUpdate event, Emitter<AddNoteState> emit) async {
    final either = await noteUseCases.getNoteUseCase(input: event.noteId);
    either.fold(
      (failure) => null,
      (note) => emit(AddNoteFormState(
        description: note.description,
        isAllInputValid: true,
        id: note.id,
        isPreview: false,
        isUpdated: true,
        title: note.title,
        titleErrorMessage: null,
      )),
    );
  }
}
