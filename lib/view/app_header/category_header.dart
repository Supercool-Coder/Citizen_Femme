import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CategoryAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(), // Remove the back arrow
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF000000),
              fontFamily: 'Roboto',
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              height: 22 / 14, // line-height / font-size
              letterSpacing: -0.41, // Rounded to 3 decimal places
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
