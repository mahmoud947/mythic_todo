part of 'preview_cubit.dart';

@immutable
abstract class PreviewState extends Equatable {
  const PreviewState();

  @override
  List<Object> get props => [];
}

@immutable
class PreviewInitial extends PreviewState {}

@immutable
class PreviewLoadingState extends PreviewState {}

@immutable
class PreviewErrorState extends PreviewState {
  const PreviewErrorState({
    required this.message,
  });
  final String message;
  @override
  List<Object> get props => [message];
}

@immutable
class PreviewSuccessState extends PreviewState {
  const PreviewSuccessState({required this.note});
  final Note note;
  @override
  List<Object> get props => [note.id, note.title, note.description];
}
