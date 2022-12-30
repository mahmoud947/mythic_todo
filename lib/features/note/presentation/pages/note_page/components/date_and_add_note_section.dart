import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/app_routes.dart';
import '../../../../../../common/app_size.dart';

class DateAndAddNoteSection extends StatelessWidget {
  const DateAndAddNoteSection({super.key, required this.date});

  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Today', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpace.regular),
            Text(date, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addNotsScreen);
              },
              icon: FaIcon(
                FontAwesomeIcons.plus,
                size: 7.w,
              ),
            ),
          ],
        )
      ],
    );
  }
}
