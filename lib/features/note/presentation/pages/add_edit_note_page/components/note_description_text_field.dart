import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoteBodyTextField extends StatelessWidget {
  const NoteBodyTextField({
    Key? key,
    this.onTextChange,
    required this.controller,
    this.initialValue,
  }) : super(key: key);
  final Function(String value)? onTextChange;
  final TextEditingController controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        controller: controller,
        onChanged: onTextChange,
        maxLines: 100,
        minLines: 100,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.color
                  ?.withAlpha(130),
              fontSize: 12.sp),
          border: InputBorder.none,
          hintText: 'Note Body',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
