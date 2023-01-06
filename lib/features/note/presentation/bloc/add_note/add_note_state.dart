// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_note_bloc.dart';

abstract class AddNoteState extends Equatable {
  const AddNoteState();

  @override
  List<Object?> get props => [];
}

class AddNoteErrorState extends AddNoteState {
  const AddNoteErrorState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class NoteAddedSuccessfulState extends AddNoteState {
  const NoteAddedSuccessfulState({
    required this.note,
  });
  final Note note;
  @override
  List<Object?> get props => [note.id, note];
}

class AddNoteFormState extends AddNoteState {
  const AddNoteFormState({
    this.title = '',
    this.description = '',
    this.isAllInputValid = false,
    this.titleErrorMessage,
    this.isPreview = false,
  });
  final String title;
  final String description;
  final String? titleErrorMessage;
  final bool isAllInputValid;
  final bool isPreview;

  AddNoteFormState copyWith({
    String? title,
    String? description,
    bool? isAllInputValid,
    NullableWrapped<String?>? titleErrorMessage,
    bool? isPreview,
  }) {
    return AddNoteFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      isAllInputValid: isAllInputValid ?? this.isAllInputValid,
      titleErrorMessage: titleErrorMessage != null
          ? titleErrorMessage.value
          : this.titleErrorMessage,
      isPreview: isPreview ?? this.isPreview,
    );
  }

  @override
  List<Object?> get props =>
      [title, description, isAllInputValid, titleErrorMessage, isPreview];
}
