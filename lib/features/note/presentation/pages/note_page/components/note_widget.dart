import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/platform/utils/exetension.dart';
import '../../../../data/util/note_extension.dart';
import '../../../../domain/entities/note.dart';
import '../../../cubit/home/home_cubit.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note, required this.onClick});
  final Note note;
  final Function(String noteId) onClick;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurBackgroundColor: Colors.black,
      onPressed: () => onClick(note.id),
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color:
            context.isDarkMode ? Colors.black26.withAlpha(100) : Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Center(
                        child: Text(
                          note.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontSize: 14.sp,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundColor: note.color.intColor,
                        radius: 2.w,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 5,
                  child: Markdown(
                    data: note.description,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
