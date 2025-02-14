import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/colors.dart';

double screenHeight = 0;
double screenWidth = 0;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

textStyle(
    {double? fontSize, Color? color, FontWeight? weight, double? spacing}) {
  return TextStyle(
      fontSize: fontSize ?? 16.h,
      color: color ?? AppColors.whiteA700,
      fontWeight: weight ?? FontWeight.normal,
      letterSpacing: spacing);
}

spaceHeight([double? height]) {
  return SizedBox(height: height ?? 16.h);
}

spaceWidth([double? width]) {
  return SizedBox(width: width ?? 16.w);
}

switchScreenPush(context, screen) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, __, _) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

switchScreenReplacement(context, screen) {
  return Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

switchScreenPushRTL(context, screen) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, __, _) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = __.drive(tween);
        return SlideTransition(position: offsetAnimation, child: screen);
      },
      transitionDuration: const Duration(milliseconds: 120), // Duration.zero,
      reverseTransitionDuration:
          const Duration(milliseconds: 120), // Duration.zero,
    ),
  );
}

String alphabet(int index) {
  return String.fromCharCodes(
    Iterable.generate(1, (x) => 'a'.codeUnitAt(0) + index),
  ).toUpperCase();
}

backIcon(BuildContext context) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_new_rounded,
      color: AppColors.whiteA700,
    ),
    onPressed: () => Navigator.of(context).pop(),
  );
}
