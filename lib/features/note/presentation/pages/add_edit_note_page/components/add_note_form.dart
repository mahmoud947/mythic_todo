import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/add_note/add_note_bloc.dart';
import 'note_description_text_field.dart';
import 'note_title_text_field.dart';

class AddNoteForm extends StatelessWidget {
  const AddNoteForm({
    super.key,
    required this.state,
    required this.scrollController,
    required this.descriptionController,
    required this.titleController,
  });
  final AddNoteFormState state;
  final ScrollController scrollController;
  final TextEditingController descriptionController;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        NoteTitleTextField(
          textEditingController: titleController,
          onTextChange: (value) => context.read<AddNoteBloc>().add(
                OnTitleChange(title: value),
              ),
          errorMessage: state.titleErrorMessage,
        ),
        Flexible(
          child: NoteBodyTextField(
            controller: descriptionController,
            onTextChange: (value) {
              context.read<AddNoteBloc>().add(
                    OnDescriptionChange(description: value),
                  );
              if (state.isPreview &&
                  descriptionController
                          .text[descriptionController.text.length - 1] ==
                      '\n') {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
