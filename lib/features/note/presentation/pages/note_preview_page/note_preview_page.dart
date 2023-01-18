import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../cubit/preview/preview_cubit.dart';

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
            const SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('preview'),
              ),
              floating: true,
              actions: [
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 18,
                      )),
                ),
              ],
              snap: true,
            )
          ];
        },
        body: BlocBuilder<PreviewCubit, PreviewState>(
          builder: (_, state) {
            if (state is PreviewSuccessState) {
              return Markdown(data: state.note.description);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
