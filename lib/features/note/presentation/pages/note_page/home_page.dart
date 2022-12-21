import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/extensions.dart';
import '../../../../../common/app_routes.dart';
import '../../../../../common/image_resources.dart';
import '../../../../auth/domain/model/user_model.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_fonts.dart';
import '../../../../../common/app_size.dart';
import '../../../data/util/note_extension.dart';
import '../../../domain/entities/note.dart';
import '../../cubit/home/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getNotes();
  }

  @override
  void dispose() {
    context.read<HomeCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: _buildDateSelectedAndAddTaskSection(context),
            ),
            _buildDatePickerSection(context),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (_, state) {
                  if (state is GetNoteSuccessfulState) {
                    return ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (_, index) {
                        if (state.notes.isNotEmpty) {
                          return _noteWidget(
                            context,
                            state.notes[index]!,
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _noteWidget(BuildContext context, Note note) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.1),
      ),
      elevation: 2,
      color: note.color.intColor,
      child: ExpansionTile(
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '${note.startTime} AM',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.lightOnNoteColor),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(14),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.description,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.lightOnNoteColor),
          ),
          const SizedBox(height: AppSpace.regular),
          Row(
            children: [
              Text(
                'Completed',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.lightOnNoteColor),
              ),
              Checkbox(
                value: note.isCompleted,
                onChanged: (isChecked) {},
                checkColor: note.color.intColor,
                activeColor: Colors.black87,
              ),
            ],
          )
        ],
      ),
    );
  }

  Row _buildDateSelectedAndAddTaskSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Today', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpace.regular),
            Text('April 27,2022', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // NoteModel noteModel = NoteModel(
                //     title: 'hello',
                //     color: NoteColor.green,
                //     description: 'this a dddd',
                //     isCompleted: true,
                //     reminder: true,
                //     startTime: DateTime.now().toString(),
                //     id: Random().nextInt(1000));
                // context.read<HomeBloc>().add(InsertNoteEvent(note: noteModel));
                Navigator.of(context).pushNamed(AppRoutes.addNotsScreen);
              },
              icon: Icon(
                Icons.add_circle_rounded,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              'Task',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }

  DatePicker _buildDatePickerSection(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      selectionColor: Theme.of(context).colorScheme.primary,
      monthTextStyle: const TextStyle(fontSize: AppFontSize.extraSaml),
      dayTextStyle: const TextStyle(fontSize: AppFontSize.extraSaml),
      dateTextStyle: const TextStyle(fontSize: AppFontSize.body1),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      leadingWidth: 140,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => {},
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: widget.userModel.imageUrl != null
                  ? NetworkImage(widget.userModel.imageUrl.orEmpty())
                  : const AssetImage(ImageResources.emptyAvatar)
                      as ImageProvider,
            ),
          ),
          Flexible(
            child: Text(
              widget.userModel.displayName,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () => {context.read<HomeCubit>().deleteAllNote()},
            icon: Icon(
              Icons.search,
              size: 32,
              color: Theme.of(context).colorScheme.onBackground,
            ))
      ],
      title: Text(
        'Home',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontFamily: AppFontConstants.inconsolataFontFamily,
          fontSize: AppFontSize.titleMedium,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}
