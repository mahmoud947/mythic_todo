import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import '../../../../auth/domain/model/user_model.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_fonts.dart';
import '../../../../../common/app_size.dart';
import '../../../data/models/note_model.dart';
import '../../../data/util/note_extension.dart';
import '../../../domain/entities/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;
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
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return _noteWidget(
                        context,
                        Note(
                            id: index,
                            title: 'it is a title',
                            description:
                                'this is a description an more for just test we can do it if we work to gether',
                            startTime: 'startTime',
                            endTime: 'endTime',
                            color: NoteColor.babyBlue,
                            isCompleted: true,
                            reminder: true));
                  }),
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
              onPressed: () {},
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
              backgroundImage: NetworkImage(userModel.imageUrl),
            ),
          ),
          Flexible(
            child: Text(
              userModel.displayName,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () => {},
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
