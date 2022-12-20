// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetNoteLoadingState extends HomeState {}

class InsertNoteSuccessfulState extends HomeState {}

class GetNoteErrorState extends HomeState {
  const GetNoteErrorState({
    required this.message,
  });
  final String message;
}

class GetNoteSuccessfulState extends HomeState {
  const GetNoteSuccessfulState({
    required this.notes,
  });
  final List<Note> notes;
}
