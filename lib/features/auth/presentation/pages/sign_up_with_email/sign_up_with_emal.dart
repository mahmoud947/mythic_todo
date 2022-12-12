import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mythic_todo/common/app_strings.dart';
import 'package:mythic_todo/core/platform/widgets/custom_elevated_button.dart';
import 'package:mythic_todo/core/platform/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class SignUpWithEmail extends StatelessWidget {
  const SignUpWithEmail({super.key});

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
                height: 18.h,
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
                child: Form(
                  child: Column(
                    children: const [
                      CustomTextField(
                        hint: 'First Name',
                        icon: Icons.text_fields,
                      ),
                      CustomTextField(
                        hint: 'Last Name',
                        icon: Icons.text_fields,
                      ),
                      CustomTextField(
                        hint: 'Email',
                        icon: Icons.email,
                      ),
                      CustomTextField(
                        hint: 'Password',
                        textFieldType: TextFieldType.password,
                      ),
                      CustomTextField(
                        hint: 'Confirm Password',
                        textFieldType: TextFieldType.password,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 80.h,
              child:
                  CustomElevatedButton(onClick: () {}, text: AppStrings.signUp),
            )
          ],
        ),
      ),
    );
  }
}
