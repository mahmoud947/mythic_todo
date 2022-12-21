import 'package:flutter/material.dart';

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
