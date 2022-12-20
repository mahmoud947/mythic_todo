import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/core/util/wrappers.dart';
import 'package:mythic_todo/features/note/domain/usecases/validation/note_title_validation_use_case.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteTitleValidationUseCase noteTitleValidationUseCase;
  AddNoteBloc({required this.noteTitleValidationUseCase})
      : super(const AddNoteFormState()) {
    on<OnTitleChange>((event, emit) => _onTitleChange(event, emit));
    on<OnDescriptionChange>((event, emit) => null);
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

  void _isAllInputValid(OnTitleChange event, Emitter<AddNoteState> emit) {
    final currentState = state as AddNoteFormState;
    final isAllInputValued = currentState.title.isNotEmpty;

    emit(currentState.copyWith(isAllInputValid: isAllInputValued));
  }
}
