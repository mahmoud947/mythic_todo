import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/platform/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                hint: 'Email',
                textFieldType: TextFieldType.normal,
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is requeued';
                  }
                  return null;
                },
              ),
              CustomTextField(
                hint: 'password',
                textFieldType: TextFieldType.password,
                icon: Icons.lock,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is requeued';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
