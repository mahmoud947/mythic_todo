import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/platform/widgets/custom_elevated_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_routes.dart';
import '../../../../../common/app_strings.dart';
import '../../widgets/canvas_circle.dart';
import '../../widgets/clickable_texts.dart';
import '../../widgets/google_button.dart';
import '../../widgets/red_top_left_circle.dart';
import '../../widgets/small_yellow_circle.dart';
import '../../widgets/text_on_divider.dart';
import '../../widgets/top_left_text.dart';
import '../../widgets/top_title.dart';

import 'widgets/login_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ??
          const SystemUiOverlayStyle(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              const RedTopLeftCircle(),
              const TopLeftText(),
              const SmallYellowCircle(),
              const TopTitle(title: AppStrings.welcomeToMythicTodo),
              Positioned(
                top: 55.h,
                left: -12.5.w,
                width: 25.w,
                height: 25.w,
                child: CustomPaint(
                  foregroundPainter: CanvasCircle(
                    color: AppColors.lightTurquoise,
                  ),
                ),
              ),
              LoginForm(formKey: formKey),
              Positioned(
                top: 80.h,
                left: 0,
                right: 0,
                child: CustomElevatedButton(
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                    } else {}
                  },
                  text: AppStrings.signIn,
                ),
              ),
              Positioned(
                top: 73.5.h,
                left: 0,
                right: 0,
                child: const TextOnDivider(),
              ),
              Positioned(
                top: 70.h,
                right: -10.w,
                width: 20.w,
                height: 20.w,
                child: CustomPaint(
                  foregroundPainter: CanvasCircle(
                    color: AppColors.pink,
                  ),
                ),
              ),
              Positioned(
                top: 65.h,
                left: 0,
                right: 0,
                child: GoogleButton(
                  text: 'Sign in with Google',
                  onClick: () {},
                ),
              ),
              Positioned(
                top: 90.h,
                left: 0,
                right: 0,
                child: ClickableTexts(
                  prefixText: AppStrings.doNotHaveAnAccount,
                  postfixText: AppStrings.signUp,
                  onPostFixTextClick: () =>
                      Navigator.of(context).pushNamed(AppRoutes.registerScreen),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
