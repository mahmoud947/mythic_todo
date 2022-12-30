import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../../../data/util/note_extension.dart';
import '../../../cubit/home/home_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../domain/entities/note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurBackgroundColor: Colors.black,
      blurSize: 8,
      menuItems: [
        FocusedMenuItem(
          title: const Text('Edit',
              style: TextStyle(
                color: Colors.black,
              )),
          trailingIcon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          onPressed: () {},
        ),
        FocusedMenuItem(
          title: const Text('Share',
              style: TextStyle(
                color: Colors.black,
              )),
          trailingIcon: const Icon(
            Icons.share,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          onPressed: () {},
        ),
        FocusedMenuItem(
          title: const Text('Delete'),
          trailingIcon: const Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onPressed: () {
            context.read<HomeCubit>().deleteNote(note);
          },
        ),
      ],
      onPressed: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.1),
        ),
        elevation: 2,
        color: note.color.intColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  note.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14.sp,
                      ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  note.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.lightOnNoteColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
