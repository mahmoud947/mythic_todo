import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mythic_todo/core/platorm/utils/exetension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_strings.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onClick, required this.text});
  final Function() onClick;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 7.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.0, 6.0),
                blurRadius: 10.0,
                color: context.isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade400,
              )
            ]),
        child: Text(
          text,
          style: GoogleFonts.athiti(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
