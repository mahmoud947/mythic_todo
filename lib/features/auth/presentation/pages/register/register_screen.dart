import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/common/app_routes.dart';
import 'package:mythic_todo/core/platform/utils/exetension.dart';
import 'package:mythic_todo/core/util/extensions.dart';
import 'package:mythic_todo/features/auth/presentation/bloc/register/register_bloc.dart';
import '../../../../../common/app_strings.dart';
import '../../../../../core/platform/widgets/custom_elevated_button.dart';
import '../../widgets/over_lapping_circles.dart';
import '../../widgets/canvas_line_end_with_circle.dart';
import '../../widgets/google_button.dart';
import '../../widgets/red_top_left_circle.dart';
import '../../widgets/text_on_divider.dart';
import '../../widgets/top_left_text.dart';
import '../../widgets/top_title.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/clickable_texts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ??
          const SystemUiOverlayStyle(),
      child: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (_, state) {
            if (state is RegisterLoading) {
              context.showSnackBar('Loading');
            } else if (state is RegisterError) {
              context.showSnackBar(state.message);
            } else if (state is RegisterSuccessfully) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  arguments: state.userModel,
                  AppRoutes.notsScreen,
                  (route) => false);
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                const RedTopLeftCircle(),
                const TopLeftText(),
                const TopTitle(title: AppStrings.register),
                Positioned(
                  height: 30.h,
                  top: 25.h,
                  left: 50.w,
                  child: CustomPaint(
                    foregroundPainter: LineEndWithCircle(
                      color: Colors.red,
                      circleRadius: 6.w,
                    ),
                  ),
                ),
                Positioned(
                  top: 73.5.h,
                  left: 0,
                  right: 0,
                  child: const TextOnDivider(),
                ),
                Positioned(
                  top: 40.h,
                  left: -15.w,
                  width: 65.w,
                  height: 65.w,
                  child: CustomPaint(
                    foregroundPainter: OverLappingCircles(
                      color: const Color(0XFFFFAFDF),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.h,
                  right: -15.w,
                  width: 65.w,
                  height: 65.w,
                  child: Transform.rotate(
                    angle: pi,
                    child: CustomPaint(
                      foregroundPainter: OverLappingCircles(
                        overLapping: 0.6,
                        color: const Color(0XFFD5CFF4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 65.h,
                  left: 0,
                  right: 0,
                  child: GoogleButton(
                    onClick: () {
                      context.read<RegisterBloc>().add(SignInWithGoogleEvent());
                    },
                    text: 'Sign up with Google',
                  ),
                ),
                Positioned(
                  top: 80.h,
                  left: 0,
                  right: 0,
                  child: CustomElevatedButton(
                      onClick: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.signUpWithEmailScreen);
                      },
                      text: 'SignUp with Email'),
                ),
                Positioned(
                  top: 90.h,
                  left: 0,
                  right: 0,
                  child: ClickableTexts(
                    prefixText: AppStrings.alreadyHaveAnAccount,
                    postfixText: AppStrings.signIn,
                    onPostFixTextClick: () => Navigator.of(context).pop(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
