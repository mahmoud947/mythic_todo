// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_note_bloc.dart';

abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object> get props => [];
}

class OnTitleChange extends AddNoteEvent {
  final String title;
  const OnTitleChange({
    required this.title,
  });
  @override
  List<Object> get props => [title];
}

class OnSubmitEvent extends AddNoteEvent {}

class TogglePreview extends AddNoteEvent {}

class Clear extends AddNoteEvent {}

class OnDescriptionChange extends AddNoteEvent {
  final String description;
  const OnDescriptionChange({
    required this.description,
  });
  @override
  List<Object> get props => [description];
}
