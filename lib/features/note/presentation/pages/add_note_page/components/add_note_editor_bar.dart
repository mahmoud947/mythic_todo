import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'font_size_selector.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/add_note/add_note_bloc.dart';
import 'add_note_text_editor_bar_button.dart';

class AddNoteTextEditorBar extends StatelessWidget {
  const AddNoteTextEditorBar(
      {super.key, required this.controller, required this.picker});
  final TextEditingController controller;
  final ImagePicker picker;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.bold,
            onClick: () {
              controller.text += '****';
              _setTextEditorControllerPosition(
                controller: controller,
                positionFromLastCharacter: 2,
              );
            },
          ),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.images,
            onClick: () => _pickImage(
              onSuccess: () {
                context
                    .read<AddNoteBloc>()
                    .add(OnDescriptionChange(description: controller.text));
                _setTextEditorControllerPosition(controller: controller);
              },
            ),
          ),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.italic,
            onClick: () {},
          ),
          AddNoteFontSizeSelector(controller: controller),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.underline,
            onClick: () {},
          ),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.circleDot,
            onClick: () {},
          ),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.quoteLeft,
            onClick: () {
              controller.text += '> ';
              _setTextEditorControllerPosition(controller: controller);
            },
          ),
          AddNoteTextEditorBarButton(
            iconData: FontAwesomeIcons.code,
            onClick: () {
              controller.text += '``````';
              _setTextEditorControllerPosition(
                controller: controller,
                positionFromLastCharacter: 3,
              );
            },
          )
        ],
      ),
    );
  }

  void _setTextEditorControllerPosition({
    required TextEditingController controller,
    int positionFromLastCharacter = 0,
  }) {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length - positionFromLastCharacter),
    );
  }

  void _pickImage({required VoidCallback onSuccess}) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      controller.text += '![enter image description here](${image.path})\n';
      onSuccess.call();
    }
  }
}
