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
  List<Object?> get props => [note.id, note, note.description, note.title];
}

class NoteUpdatedSuccessfulState extends AddNoteState {
  const NoteUpdatedSuccessfulState({
    required this.note,
  });
  final Note note;
  @override
  List<Object?> get props => [note.id, note, note.description, note.title];
}

class AddNoteFormState extends AddNoteState {
  const AddNoteFormState({
    this.id,
    this.title = '',
    this.description = '',
    this.isAllInputValid = false,
    this.titleErrorMessage,
    this.isPreview = false,
    this.isUpdated = false,
  });
  final String title;
  final String? id;
  final String description;
  final String? titleErrorMessage;
  final bool isAllInputValid;
  final bool isPreview;
  final bool isUpdated;

  AddNoteFormState copyWith({
    String? title,
    NullableWrapped<String?>? id,
    String? description,
    bool? isAllInputValid,
    NullableWrapped<String?>? titleErrorMessage,
    bool? isPreview,
    bool? isUpdated,
  }) {
    return AddNoteFormState(
        title: title ?? this.title,
        id: id != null ? id.value : this.id,
        description: description ?? this.description,
        isAllInputValid: isAllInputValid ?? this.isAllInputValid,
        titleErrorMessage: titleErrorMessage != null
            ? titleErrorMessage.value
            : this.titleErrorMessage,
        isPreview: isPreview ?? this.isPreview,
        isUpdated: isUpdated ?? this.isUpdated);
  }

  @override
  List<Object?> get props => [
        title,
        id,
        description,
        isAllInputValid,
        titleErrorMessage,
        isPreview,
        isUpdated
      ];
}
