import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../cubit/preview/preview_cubit.dart';

import '../../../../../../common/app_routes.dart';

class NotePreviewAppBar extends StatelessWidget {
  const NotePreviewAppBar({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final String noteId;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: BlocBuilder<PreviewCubit, PreviewState>(
          builder: (context, state) {
            if (state is PreviewSuccessState) {
              return Text(state.note.title);
            }
            return Container();
          },
        ),
      ),
      floating: true,
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.addNotsScreen, arguments: noteId);
          },
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ),
        ),
      ],
      snap: true,
    );
  }
}
