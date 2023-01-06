import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      daysCount: 10,
      height: SizerUtil.deviceType == DeviceType.tablet ? 10.5.h : 80,
      width: SizerUtil.deviceType == DeviceType.tablet ? 12.w : 60,
      onDateChange: (selectedDate) {
        print('date $selectedDate');
      },
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Theme.of(context).colorScheme.primary,
      monthTextStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9.sp) ??
              const TextStyle(),
      dayTextStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 7.sp) ??
              const TextStyle(),
      dateTextStyle:
          Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9.sp) ??
              const TextStyle(),
    );
  }
}
