import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/image_resources.dart';
import '../../../cubit/home/home_cubit.dart';
import 'date_and_add_note_section.dart';
import 'date_picker_section.dart';
import 'note_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: DateAndAddNoteSection(date: date),
          ),
          const DatePickerSection(),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (_, state) {
                if (state is GetNoteSuccessfulState) {
                  if (state.notes.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50.w,
                        mainAxisExtent: 30.h,
                      ),
                      itemCount: state.notes.length,
                      itemBuilder: (_, index) {
                        return NoteWidget(
                          note: state.notes[index]!,
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
