import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/app_strings.dart';
import '../../../../../../core/platform/utils/exetension.dart';
import '../../../bloc/add_note/add_note_bloc.dart';

AppBar addNoteAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: Theme.of(context).colorScheme.onBackground,
      size: 8.w,
    ),
    actions: [
      IconButton(
        onPressed: () {
          context.read<AddNoteBloc>().add(TogglePreview());
        },
        icon: const Icon(
          Icons.view_array,
          color: Colors.green,
        ),
      ),
      BlocConsumer<AddNoteBloc, AddNoteState>(
        listener: (_, state) {
          if (state is NoteAddedSuccessfulState) {
            context.showSnackBar('Note added Successfully');
            Navigator.of(context).pop();
          } else if (state is NoteUpdatedSuccessfulState) {
            context.showSnackBar('Note Updated Successfully');
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AddNoteFormState) {
            return IconButton(
              icon: Icon(
                Icons.check_circle,
                color: state.isAllInputValid
                    ? Colors.green
                    : Colors.green.withAlpha(100),
              ),
              onPressed: state.isAllInputValid
                  ? () => context.read<AddNoteBloc>().add(OnSubmitEvent())
                  : null,
            );
          } else {
            return Container();
          }
        },
      ),
    ],
    title: Text(
      AppStrings.addNote,
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
    ),
  );
}
