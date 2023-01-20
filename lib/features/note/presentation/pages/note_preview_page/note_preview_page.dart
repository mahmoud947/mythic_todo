import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/preview/preview_cubit.dart';
import 'components/note_preview_app_bar.dart';
import 'components/note_preview_body.dart';

class NotePreviewPage extends StatefulWidget {
  const NotePreviewPage({super.key, required this.noteId});
  final String noteId;

  @override
  State<NotePreviewPage> createState() => _NotePreviewPageState();
}

class _NotePreviewPageState extends State<NotePreviewPage> {
  @override
  void initState() {
    context.read<PreviewCubit>().getNote(noteId: widget.noteId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            NotePreviewAppBar(
              noteId: widget.noteId,
            )
          ];
        },
        body: const NotePreviewBody(),
      ),
    );
  }
}
