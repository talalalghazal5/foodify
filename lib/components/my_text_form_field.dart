import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTextFormField extends StatefulWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool isReadOnly;
  const MyTextFormField(
      {super.key,
      required this.hintText,
      required this.inputType,
      required this.controller,
      this.isReadOnly = false,});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.isReadOnly,
      controller: widget.controller,
      smartDashesType: widget.inputType == TextInputType.number
          ? SmartDashesType.enabled
          : SmartDashesType.disabled,
      canRequestFocus: true,
      dragStartBehavior: DragStartBehavior.down,
      keyboardType: widget.inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
          fontFamily: 'sf_pro_display_regular',
          fontFamilyFallback: const ['sf_arabic'],
          color: Theme.of(context).colorScheme.inversePrimary),
      decoration: InputDecoration(
          suffixIcon: widget.inputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? const FaIcon(FontAwesomeIcons.eye)
                      : const FaIcon(FontAwesomeIcons.eyeSlash))
              : null,
          // FOCUSED CASE:
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.error)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.inversePrimary),
          ),
          // ERROR CASE:
          errorStyle: const TextStyle(
            fontFamily: 'sf_pro_display_regular',
          ),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.error)),
          // NORMAL CASE:
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(8)),
          // HINT STYLING:
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'sf_pro_display_regular',
            color: Theme.of(context).colorScheme.primary,
          )),
      obscureText:
          widget.inputType == TextInputType.visiblePassword ? isObscure : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your ${widget.hintText.toLowerCase()}';
        }
        if (widget.inputType == TextInputType.emailAddress &&
            !EmailValidator.validate(value)) {
          return 'please enter a valid e-mail';
        }
        if (widget.inputType == TextInputType.text &&
            widget.hintText == 'First name') {}
        return null;
      },
    );
  }
}
