import 'package:flutter/material.dart';

import 'components/add_note_app_bar.dart';
import 'components/add_note_body.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addNoteAppBar(context),
      body: const AddNoteBody(),
    );
  }
}
