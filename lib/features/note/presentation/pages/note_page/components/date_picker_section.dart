import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      onDateChange: (selectedDate) {
        print('date $selectedDate');
      },
      DateTime.now(),
      daysCount: 7,
      selectionColor: Theme.of(context).colorScheme.primary,
      monthTextStyle:
          Theme.of(context).textTheme.bodySmall ?? const TextStyle(),
      dayTextStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8.sp) ??
              const TextStyle(),
      dateTextStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.sp) ??
              const TextStyle(),
    );
  }
}
