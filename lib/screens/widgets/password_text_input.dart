import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample_project/utils/constants/app_constant.dart';
import 'package:sample_project/utils/images/app_images.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';
import '../../../utils/colors/app_colors.dart';

class PasswordTextInput extends StatefulWidget {
  PasswordTextInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium,
        controller: widget.controller,
        obscureText: passwordVisibility,
        validator: (String? value) {
          if (value == null || value.isEmpty || value.length < 3 ||
              !AppConstants.passwordRegExp.hasMatch(value)) {
            return "Enter true password";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration:
        InputDecoration(
            fillColor: Theme
                .of(context)
                .primaryColorLight,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(AppImages.password),
            ),
            contentPadding: const EdgeInsets.all(12),
            labelText: "Password",
            suffixIcon: IconButton(onPressed: () {
              passwordVisibility = !passwordVisibility;
              setState(() {

              });},
              icon: passwordVisibility ? Icon(Icons.visibility_off) : Icon(
                  Icons.visibility),),
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyMedium,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.transparent),
                borderRadius: BorderRadius.circular(12)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.transparent),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.transparent),
                borderRadius: BorderRadius.circular(12))
        ),
        textInputAction: TextInputAction.next,

      ),
    );
  }
}