import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/add_note/add_note_bloc.dart';
import 'note_description_text_field.dart';
import 'note_title_text_field.dart';

class AddNoteBody extends StatelessWidget {
  const AddNoteBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: BlocBuilder<AddNoteBloc, AddNoteState>(
          builder: (_, state) {
            if (state is AddNoteFormState) {
              return Column(
                children: [
                  NoteTitleTextField(
                    onTextChange: (value) => context.read<AddNoteBloc>().add(
                          OnTitleChange(title: value),
                        ),
                    errorMessage: state.titleErrorMessage,
                  ),
                  const NoteDescriptionTextField(),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      Positioned(
          bottom: 2.h,
          left: 0,
          right: 0,
          height: 5.h,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextCustomizationButton(
                  iconData: FontAwesomeIcons.bold,
                  onClick: () {},
                ),
                TextCustomizationButton(
                  iconData: FontAwesomeIcons.italic,
                  onClick: () {},
                ),
                TextCustomizationButton(
                  iconData: FontAwesomeIcons.underline,
                  onClick: () {},
                ),
                TextCustomizationButton(
                  iconData: FontAwesomeIcons.circleDot,
                  onClick: () {},
                )
              ],
            ),
          ))
    ]);
  }
}

class TextCustomizationButton extends StatelessWidget {
  final IconData iconData;
  final Function() onClick;
  const TextCustomizationButton({
    Key? key,
    required this.iconData,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onClick,
        icon: Padding(
          padding: EdgeInsets.all(1.25.w),
          child: FaIcon(
            size: 4.5.w,
            iconData,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ));
  }
}
