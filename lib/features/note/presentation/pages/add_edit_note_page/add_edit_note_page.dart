import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/note/presentation/bloc/add_note/add_note_bloc.dart';

import 'components/add_note_app_bar.dart';
import 'components/add_note_body.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, this.noteId});
  final String? noteId;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  void initState() {
    final noteId = widget.noteId;
    if (noteId != null) {
      context.read<AddNoteBloc>().add(OnGetNoteToUpdate(noteId: noteId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addNoteAppBar(context),
      body: const AddNoteBody(),
    );
  }
}
