import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/platform/widgets/custom_text_field.dart';
import '../../../bloc/sign_in/sign_in_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key, required this.state}) : super(key: key);

  final SignInFormState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              hint: 'Email',
              textFieldType: TextFieldType.normal,
              icon: Icons.email,
              onTextChange: (value) => context
                  .read<SignInBloc>()
                  .add(OnEmailChangeEvent(email: value)),
              errorText: state.emailError,
            ),
            CustomTextField(
              hint: 'password',
              textFieldType: TextFieldType.password,
              icon: Icons.lock,
              onTextChange: (value) => context
                  .read<SignInBloc>()
                  .add(OnPasswordChangeEvent(password: value)),
              errorText: state.passwordError,
            ),
          ],
        ),
      ),
    );
  }
}
