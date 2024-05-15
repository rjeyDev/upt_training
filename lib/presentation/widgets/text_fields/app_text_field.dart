import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../ui_kit/app_color.dart';
import '../../../ui_kit/app_text_style.dart';
import '../../../ui_kit/scaled_size.dart';

class AppTextField extends StatefulWidget {
  final String title;
  final String? prefix;
  final String? hintText;
  final String? mask;
  final bool obscureText;
  final Key formKey;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final double? height;
  final Widget? counter;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.title,
    this.hintText,
    this.prefix,
    this.mask,
    this.obscureText = false,
    this.validator,
    required this.formKey,
    this.controller,
    this.onChanged,
    this.height,
    this.counter,
    this.keyboardType,
  });
  @override
  State<StatefulWidget> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaledSize.widget(context, widget.height ?? 70),
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        cursorColor: AppColor.primary,
        obscureText: showPassword ? false : widget.obscureText,
        style: AppTextStyle.s14w400Black(context),
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
          return widget.counter;
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          label: Text(widget.title),
          labelStyle: AppTextStyle.s14w400Black(context),
          floatingLabelStyle: AppTextStyle.s14w400Black(context),
          // contentPadding: EdgeInsets.only(top: -15, bottom: 10),
          prefix: Text(widget.prefix ?? ''),
          prefixStyle: AppTextStyle.s14w400Black(context),
          hintText: widget.hintText,
          hintStyle: AppTextStyle.s12w400Grey(context),

          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset(
                        showPassword ? 'assets/icons/eye_open.svg' : 'assets/icons/eye_closed.svg',
                        width: ScaledSize.widget(context, 24),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}
