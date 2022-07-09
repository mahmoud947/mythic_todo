import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mythic_todo/common/app_strings.dart';
import 'package:mythic_todo/common/image_resources.dart';

import '../../../../common/app_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            ImageResources.splashScreenBackground,
            fit: BoxFit.cover,
          ),
          Align(
            child: SvgPicture.asset(ImageResources.applicationLogo),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.splashScreenSubTitle,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: AppFontSize.body1,
                    fontFamily: AppFontConstants.pacificoFontFamily),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
