import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mythic_todo/common/app_fonts.dart';
import 'package:mythic_todo/common/app_size.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';
import '../../../data/util/note_extension.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

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
            // ListView.builder(
            //   itemCount: ,
            //   itemBuilder: (_, index){

            // })
          ],
        ),
      ),
    );
  }

  Card _buildNote(BuildContext context, Note note) {
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
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: AppFontSize.overLine,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            Text(
              '${note.startTime} AM',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: AppFontSize.overLine,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(14),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: AppFontSize.overLine,
              fontWeight: AppFontWeight.regular,
            ),
          ),
          const SizedBox(height: AppSpace.regular),
          Row(
            children: [
              Text(
                'Completed',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: AppFontSize.overLine,
                  fontWeight: AppFontWeight.bold,
                ),
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
            Text(
              'Today',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: AppFontSize.title,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpace.regular),
            Text(
              'April 27,2022',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: AppFontSize.saml,
                fontWeight: AppFontWeight.regular,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_rounded,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'Task',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: AppFontSize.body1,
                fontWeight: AppFontWeight.bold,
              ),
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
      leading: IconButton(
        onPressed: () => {},
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 17,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onBackground,
          size: 34,
        )
      ],
      title: Text(
        'Home',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontFamily: AppFontConstants.inconsolataFontFamily,
          fontSize: AppFontSize.title,
          fontWeight: AppFontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
