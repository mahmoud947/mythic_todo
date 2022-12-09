import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClickableTexts extends StatelessWidget {
  const ClickableTexts({
    Key? key,
    required this.postfixText,
    required this.prefixText,
    this.onPostFixTextClick,
    this.onPrefixTextClick,
  }) : super(key: key);

  final String prefixText;
  final String postfixText;
  final Function()? onPrefixTextClick;
  final Function()? onPostFixTextClick;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        GestureDetector(
          onTap: onPostFixTextClick,
          child: Text(
            prefixText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SizedBox(width: 2.w),
        GestureDetector(
          onTap: onPrefixTextClick,
          child: Text(
            postfixText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ],
    );
  }
}
