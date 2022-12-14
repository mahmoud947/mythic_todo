import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

enum TextFieldType {
  normal,
  password,
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.textFieldType = TextFieldType.normal,
    this.icon,
    this.hint,
    this.onTextChange,
    this.validator,
    this.errorText,
  });
  final TextFieldType textFieldType;
  final IconData? icon;
  final String? hint;
  final Function(String)? onTextChange;
  final String? Function(String?)? validator;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    switch (textFieldType) {
      case TextFieldType.normal:
        return NormalTextField(
          hint: hint,
          icon: icon,
          onTextChange: onTextChange,
          validator: validator,
          errorText: errorText,
        );

      case TextFieldType.password:
        return PasswordTextField(
          hint: hint,
          icon: icon,
          onTextChange: onTextChange,
          validator: validator,
          errorText: errorText,
        );
    }
  }
}

class PasswordTextField extends HookWidget {
  const PasswordTextField({
    Key? key,
    required this.hint,
    this.icon,
    this.onTextChange,
    this.validator,
    this.errorText,
  }) : super(key: key);

  final String? hint;
  final IconData? icon;
  final Function(String)? onTextChange;
  final String? Function(String?)? validator;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    final isVisible = useState(false);
    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 2.w),
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Visibility(
        visible: icon == null ? false : true,
        replacement: TextFormField(
          validator: validator,
          onChanged: onTextChange,
          obscureText: !isVisible.value,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: GestureDetector(
              onTap: () {
                isVisible.value = !isVisible.value;
              },
              child: Icon(
                  isVisible.value ? Icons.visibility_off : Icons.visibility),
            ),
            errorText: errorText,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        child: TextFormField(
          onChanged: onTextChange,
          validator: validator,
          obscureText: !isVisible.value,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            suffixIcon: GestureDetector(
              onTap: () {
                isVisible.value = !isVisible.value;
              },
              child: Icon(
                  isVisible.value ? Icons.visibility_off : Icons.visibility),
            ),
            errorText: errorText,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    Key? key,
    required this.hint,
    this.icon,
    this.onTextChange,
    this.validator,
    this.errorText,
  }) : super(key: key);

  final String? hint;
  final IconData? icon;
  final Function(String)? onTextChange;
  final String? Function(String?)? validator;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 2.w),
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Visibility(
        visible: icon == null ? false : true,
        replacement: TextFormField(
          validator: validator,
          onChanged: onTextChange,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        child: TextFormField(
          validator: validator,
          onChanged: onTextChange,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            errorText: errorText,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}
