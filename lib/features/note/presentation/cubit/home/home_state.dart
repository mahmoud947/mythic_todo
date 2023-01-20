// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class GetNoteErrorState extends HomeState {
  const GetNoteErrorState({
    required this.message,
  });
  final String message;
  @override
  List<Object> get props => [message];
}

class NavigateToPreviewState extends HomeState {
  const NavigateToPreviewState({required this.noteId});
  final String noteId;
  @override
  List<Object> get props => [noteId];
}

class GetNoteSuccessfulState extends HomeState {
  GetNoteSuccessfulState({
    this.notes = const [],
  }) : uuid = const Uuid().v4();
  final List<Note?> notes;
  final String uuid;

  GetNoteSuccessfulState copyWith({List<Note>? notes}) {
    return GetNoteSuccessfulState(
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object> get props => [notes, uuid];
}
