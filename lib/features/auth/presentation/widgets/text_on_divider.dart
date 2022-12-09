import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextOnDivider extends StatelessWidget {
  const TextOnDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Divider(
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          'OR',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                background: Paint()
                  ..color = Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
