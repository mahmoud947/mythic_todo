import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_strings.dart';

class TopLeftText extends StatelessWidget {
  const TopLeftText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 11.h,
      left: 22.w,
      child: Text(
        AppStrings.moreFun,
        style: GoogleFonts.imprima(
          fontSize: 10.sp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
