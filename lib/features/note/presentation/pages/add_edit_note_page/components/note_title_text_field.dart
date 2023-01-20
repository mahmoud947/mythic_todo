import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoteTitleTextField extends StatelessWidget {
  final Function(String value)? onTextChange;
  final String? errorMessage;
  final TextEditingController textEditingController;
  const NoteTitleTextField(
      {Key? key,
      this.onTextChange,
      this.errorMessage,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        onChanged: onTextChange,
        maxLines: 1,
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        decoration: InputDecoration(
          errorText: errorMessage,
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.color
                    ?.withAlpha(130),
                fontSize: 18.sp,
              ),
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
