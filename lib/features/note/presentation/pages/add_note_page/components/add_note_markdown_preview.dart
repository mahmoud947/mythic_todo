import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../core/platform/utils/exetension.dart';

class AddNoteMarkdownPreview extends StatelessWidget {
  const AddNoteMarkdownPreview(
      {super.key, required this.data, required this.controller});
  final String data;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color:
          context.isDarkMode ? Colors.black45 : AppColors.lightBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Markdown(
        controller: controller,
        data: data,
      ),
    );
  }
}
