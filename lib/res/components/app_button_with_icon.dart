import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../global/global.dart';
import '../colors.dart';

class AppButtonWithIcon extends StatelessWidget {
  final VoidCallback onPress;
  final String btnText;
  final double? width;
  final String icon;
  final bool isBorder;
  const AppButtonWithIcon(
      {required this.btnText,
      required this.onPress,
      required this.width,
      this.isBorder = false,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
            height: 48.h,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: isBorder ? null : AppColors.black,
              border: isBorder ? Border.all(color: AppColors.whiteA700) : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.whiteA700,
                  blurRadius: 12.0,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  btnText,
                  textAlign: TextAlign.center,
                  style: textStyle(
                      weight: FontWeight.w600,
                      color: !isBorder ? AppColors.black1 : null),
                ))
              ],
            )));
  }
}
