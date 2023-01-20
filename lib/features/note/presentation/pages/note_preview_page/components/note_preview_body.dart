import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../cubit/preview/preview_cubit.dart';

class NotePreviewBody extends StatelessWidget {
  const NotePreviewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewCubit, PreviewState>(
      builder: (_, state) {
        if (state is PreviewSuccessState) {
          return Markdown(data: state.note.description);
        } else {
          return Container();
        }
      },
    );
  }
}
