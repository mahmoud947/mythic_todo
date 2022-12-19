import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/platform/utils/exetension.dart';
import '../../../../../core/platform/widgets/custom_elevated_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_routes.dart';
import '../../../../../common/app_strings.dart';
import '../../bloc/sign_in/sign_in_bloc.dart';
import '../../widgets/canvas_circle.dart';
import '../../widgets/clickable_texts.dart';
import '../../widgets/google_button.dart';
import '../../widgets/red_top_left_circle.dart';
import '../../widgets/small_yellow_circle.dart';
import '../../widgets/top_left_text.dart';
import '../../widgets/top_title.dart';

import 'widgets/login_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ??
          const SystemUiOverlayStyle(),
      child: SafeArea(
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SingInErrorState) {
              context.showSnackBar(state.message);
            } else if (state is SingInSuccessfulState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  arguments: state.userModel,
                  AppRoutes.notsScreen,
                  (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
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
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (_, state) {
                      if (state is SignInFormState) {
                        return LoginForm(state: state);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if (state is SignInFormState) {
                        return Positioned(
                          top: 80.h,
                          left: 0,
                          right: 0,
                          child: CustomElevatedButton(
                            onClick: () =>
                                context.read<SignInBloc>().add(OnSubmitEvent()),
                            text: AppStrings.signIn,
                            enable: state.isFormValid,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
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
                    top: 70.h,
                    left: 0,
                    right: 0,
                    child: GoogleButton(
                      text: 'Sign in with Google',
                      onClick: () => context
                          .read<SignInBloc>()
                          .add(OnSignInWithGoogleEvent()),
                    ),
                  ),
                  Positioned(
                    top: 90.h,
                    left: 0,
                    right: 0,
                    child: ClickableTexts(
                      prefixText: AppStrings.doNotHaveAnAccount,
                      postfixText: AppStrings.signUp,
                      onPostFixTextClick: () => Navigator.of(context)
                          .pushNamed(AppRoutes.registerScreen),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
