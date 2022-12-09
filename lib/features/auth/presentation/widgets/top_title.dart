import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TopTitle extends StatelessWidget {
  const TopTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 0,
      right: 0,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.pacifico(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 28.sp,
        ),
      ),
    );
  }
}
