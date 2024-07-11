import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:citizen_femme/view_model/home_api/home_api.dart';
import 'package:citizen_femme/view_model/single_category_api/single_post_api.dart';
import 'package:citizen_femme/view_model/travel_api.dart/travel_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:citizen_femme/res/colors.dart';
import 'package:citizen_femme/view/profile/login.dart';
import 'view_model/auth_provider.dart';
import 'view_model/drawer_provider.dart';
import 'global/global.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon', // Replace with your app icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => PostCategory()),
        ChangeNotifierProvider(create: (_) => SinglePostCategory()),
      ],
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.black,
        ),
        child: ScreenUtilInit(
          designSize: Size(screenWidth, screenHeight),
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AuthProvider()),
                ChangeNotifierProvider(create: (_) => DrawerProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: AppColors.whiteA700),
                  useMaterial3: true,
                  scaffoldBackgroundColor: AppColors.whiteA700,
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    backgroundColor: AppColors.whiteA70001,
                    foregroundColor: AppColors.blueGray9004c,
                    titleTextStyle:
                        textStyle(fontSize: 26.sp, weight: FontWeight.w600),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: const BorderSide(color: AppColors.whiteA700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: const BorderSide(color: AppColors.whiteA700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: const BorderSide(color: AppColors.whiteA700),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: const BorderSide(color: AppColors.black),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteA70001,
                    ),
                  ),
                ),
                home: LogInScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
