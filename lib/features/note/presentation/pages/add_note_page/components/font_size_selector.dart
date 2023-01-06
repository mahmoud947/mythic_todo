import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

const _textEditorFontSize = {
  'H1': '# ',
  'H2': '## ',
  'H3': '### ',
  'H4': '#### ',
  'H5': '##### ',
};

class AddNoteFontSizeSelector extends StatelessWidget {
  const AddNoteFontSizeSelector({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: FaIcon(
        size: 4.5.w,
        FontAwesomeIcons.textHeight,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      itemBuilder: (_) {
        return _textEditorFontSize.keys.map((String item) {
          return PopupMenuItem(
            onTap: () {
              controller.text += _textEditorFontSize[item] ?? '';
            },
            value: _textEditorFontSize,
            child: Text(item),
          );
        }).toList();
      },
    );
  }
}
