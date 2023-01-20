import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AddNoteTextEditorBarButton extends StatelessWidget {
  final IconData iconData;
  final Function() onClick;
  const AddNoteTextEditorBarButton({
    Key? key,
    required this.iconData,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onClick,
        icon: FaIcon(
          size: 4.5.w,
          iconData,
          color: Theme.of(context).colorScheme.onPrimary,
        ));
  }
}
