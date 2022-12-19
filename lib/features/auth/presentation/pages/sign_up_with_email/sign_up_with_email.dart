import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/common/app_routes.dart';
import 'package:mythic_todo/common/app_strings.dart';
import 'package:mythic_todo/core/platform/utils/exetension.dart';
import 'package:mythic_todo/core/platform/widgets/custom_elevated_button.dart';
import 'package:mythic_todo/core/platform/widgets/custom_text_field.dart';
import 'package:mythic_todo/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:sizer/sizer.dart';

class SignUpWithEmailPage extends StatelessWidget {
  const SignUpWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(AppStrings.signUp),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.w),
                height: 15.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Join Our Community',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'get full access today.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 20.h,
              bottom: 0,
              child: SingleChildScrollView(
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessfully) {
                      context.showSnackBar('signUp successfully ');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.notsScreen, (route) => false);
                    } else if (state is SignUpErrorState) {
                      context.showSnackBar(state.message);
                    } else if (state is UserAlreadyExistState) {
                      context.showSnackBar(state.message);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.signInScreen, (route) => false);
                    }
                  },
                  buildWhen: (previous, current) => current is SignUpFormState,
                  builder: (_, state) {
                    if (state is SignUpFormState) {
                      return SignUpForm(state: state);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SignUpFormState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hint: 'First Name',
          icon: Icons.text_fields,
          onTextChange: (value) => context.read<SignUpBloc>().add(
                OnFirstNameChangeEvent(firstName: value),
              ),
          errorText: state.firstNameError,
        ),
        CustomTextField(
          hint: 'Last Name',
          icon: Icons.text_fields,
          onTextChange: (value) => context.read<SignUpBloc>().add(
                OnLastNameChangeEvent(lastName: value),
              ),
          errorText: state.lastNameError,
        ),
        CustomTextField(
          hint: 'Email',
          icon: Icons.email,
          onTextChange: (value) => context.read<SignUpBloc>().add(
                OnEmailChangeEvent(email: value),
              ),
          errorText: state.emailError,
        ),
        CustomTextField(
          hint: 'Password',
          textFieldType: TextFieldType.password,
          onTextChange: (value) => context.read<SignUpBloc>().add(
                OnPasswordChangeEvent(password: value),
              ),
          errorText: state.passwordError,
        ),
        CustomTextField(
          hint: 'Confirm Password',
          textFieldType: TextFieldType.password,
          onTextChange: (value) => context.read<SignUpBloc>().add(
                OnConfirmPasswordChangeEvent(confirmPassword: value),
              ),
          errorText: state.confirmPasswordError,
        ),
        SizedBox(
          height: 3.h,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 2.h),
            child: CustomElevatedButton(
                enable: state.isFormValid,
                onClick: () {
                  context.read<SignUpBloc>().add(OnSubmitEvent());
                },
                text: AppStrings.signUp),
          ),
        ),
      ],
    );
  }
}
