import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/app_routes.dart';
import '../../../../../../common/image_resources.dart';
import '../../../cubit/home/home_cubit.dart';
import 'note_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (_, state) {},
              builder: (_, state) {
                if (state is GetNoteSuccessfulState) {
                  if (state.notes.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50.w,
                        childAspectRatio: 3 / 2,
                        mainAxisExtent: 30.h,
                      ),
                      itemCount: state.notes.length,
                      itemBuilder: (_, index) {
                        return NoteWidget(
                          note: state.notes[index]!,
                          onClick: (String noteId) {
                            Navigator.of(context).pushNamed(
                              AppRoutes.notePreview,
                              arguments: noteId,
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center(
                    child: SvgPicture.asset(
                      ImageResources.emptyNotes,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
