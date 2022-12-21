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
}

class GetNoteSuccessfulState extends HomeState {
  const GetNoteSuccessfulState({this.notes = const []});
  final List<Note?> notes;

  @override
  List<Object> get props => [notes, notes.length];

  GetNoteSuccessfulState copyWith({List<Note>? notes}) {
    return GetNoteSuccessfulState(
      notes: notes ?? this.notes,
    );
  }
}
