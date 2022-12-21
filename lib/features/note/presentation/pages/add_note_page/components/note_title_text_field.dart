import 'package:flutter/material.dart';

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
