part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends HomeEvent {}

class GetNoteEvent extends HomeEvent {}

class InsertNoteEvent extends HomeEvent {
  const InsertNoteEvent({
    required this.note,
  });
  final NoteModel note;

  @override
  List<Object> get props => [note];
}
