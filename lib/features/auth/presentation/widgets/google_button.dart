import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/image_resources.dart';
import '../../../../core/platform/widgets/custom_elevated_button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.onClick, required this.text})
      : super(key: key);

  final String text;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      backgroundColor: Colors.white,
      onClick: onClick,
      text: text,
      textColor: Colors.grey.shade800,
      icon: SvgPicture.asset(
        ImageResources.gmailLogo,
      ),
    );
  }
}
