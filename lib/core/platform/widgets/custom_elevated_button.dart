import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_size.dart';
import '../utils/exetension.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onClick,
      required this.text,
      this.icon,
      this.backgroundColor,
      this.textColor});
  final Function() onClick;
  final String text;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 6.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.primary,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            Visibility(
              visible: icon != null,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                width: AppSpace.regular,
              ),
            ),
            Text(
              text,
              style: GoogleFonts.athiti(
                color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
