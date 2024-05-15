import 'package:flutter/material.dart';
import 'package:upt_training/ui_kit/app_color.dart';
import 'package:upt_training/ui_kit/scaled_size.dart';

class AppTextStyle {
  static TextStyle s12w500Primary(BuildContext context) => TextStyle(
        color: AppColor.primary,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 12),
      );

  static TextStyle s12w400Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w400,
        fontSize: ScaledSize.text(context, 12),
      );

  static TextStyle s12w400Grey(BuildContext context) => TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
        fontSize: ScaledSize.text(context, 12),
      );

  static TextStyle s12w500Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 12),
      );

  static TextStyle s14w400Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w400,
        fontSize: ScaledSize.text(context, 14),
      );

  static TextStyle s14w500White(BuildContext context) => TextStyle(
        color: AppColor.white,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 14),
      );

  static TextStyle s14w500Primary(BuildContext context) => TextStyle(
        color: AppColor.primary,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 14),
      );

  static TextStyle s14w500Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 14),
      );

  static TextStyle s16w500Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w500,
        fontSize: ScaledSize.text(context, 16),
      );

  static TextStyle s18w600Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w600,
        fontSize: ScaledSize.text(context, 18),
      );

  static TextStyle s22w700Black(BuildContext context) => TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.w700,
        fontSize: ScaledSize.text(context, 22),
      );
}
