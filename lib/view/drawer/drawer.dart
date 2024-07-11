import 'package:citizen_femme/res/colors.dart';
import 'package:citizen_femme/view/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../global/global.dart';

class AppDrawerMenu extends StatelessWidget {
  const AppDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth * 0.7,
          height: screenHeight,
          decoration: const BoxDecoration(
            color: AppColors.whiteA700,
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/header.png",
                          width: 199.w,
                        ),
                        spaceWidth(10.w),
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).closeDrawer();
                          },
                          child: const Icon(
                            Icons.clear_rounded,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        color: AppColors.black.withOpacity(0.2), height: 10),
                    spaceHeight(),
                    const DrawerItem(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
