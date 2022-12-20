import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mythic_todo/features/note/presentation/bloc/add_note/add_note_bloc.dart';
import 'package:sizer/sizer.dart';

import 'components/add_note_app_bar.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addNoteAppBar(context),
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BlocBuilder<AddNoteBloc, AddNoteState>(
            builder: (context, state) {
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
      ]),
    );
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

class NoteTitleTextField extends StatelessWidget {
  final Function(String value)? onTextChange;
  final String? errorMessage;
  const NoteTitleTextField({Key? key, this.onTextChange, this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onTextChange,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          errorText: errorMessage,
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.color
                  ?.withAlpha(130)),
          border: InputBorder.none,
          hintText: 'Task Title',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}

class NoteDescriptionTextField extends StatelessWidget {
  final Function(String value)? onTextChange;
  const NoteDescriptionTextField({
    Key? key,
    this.onTextChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onTextChange,
        maxLines: 9,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.color
                  ?.withAlpha(130)),
          border: InputBorder.none,
          hintText: 'Note Description',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
