import 'package:citizen_femme/view/common_text/easybutton.dart';
import 'package:flutter/material.dart';
import 'package:citizen_femme/view/home.dart';
import 'package:citizen_femme/global/global.dart';
import 'package:citizen_femme/view/common_text/common_text_field.dart';
import 'package:citizen_femme/view_model/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier obscurePassword = ValueNotifier<bool>(true);

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              spaceHeight(40.h),
              Container(
                width: 65.w,
                height: 24.h,
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Domine',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 24, // Line height / Font size
                    letterSpacing: -0.40799999237060547,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              spaceHeight(24.h),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username / Email", // Title of the input box
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      controller: emailController,
                      hintText: "Enter the subject",
                      keyboardType: TextInputType.text,
                      hasError: false,
                    ),
                  ],
                ),
              ),
              spaceHeight(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password", // Title of the input box
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CommonTextField(
                    controller: passwordController,
                    hintText: "Enter the subject",
                    keyboardType: TextInputType.text,
                    hasError: false,
                  ),
                ],
              ),
              spaceHeight(),
              Row(
                children: [
                  Consumer<AuthProvider>(builder: (context, auth, child) {
                    return Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: auth.isRemember,
                      onChanged: (value) {
                        auth.setRemember(value!);
                      },
                      activeColor: AppColors.lightblueA700,
                      checkColor: AppColors.whiteA700,
                    );
                  }),
                  Text(
                    'Remember me',
                    style: textStyle(
                        fontSize: 14.sp,
                        weight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              spaceHeight(),
              EasyButton(
                idleStateWidget: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Domine',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    // Convert line height to relative value
                    letterSpacing: -0.408,
                  ),
                  textAlign: TextAlign.center,
                  // lineHeight:  22 / 24
                ),
                loadingStateWidget: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: double.infinity,
                height: 50.0,
                borderRadius:
                    0.0, // Set borderRadius to 0 for rectangular shape
                buttonColor: AppColors.black,
                onPressed: () async {
                  await authProvider.login(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                    context,
                  );

                  if (authProvider.loading) {
                    return;
                  }

                  if (authProvider.loggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Successful!'),
                      ),
                    );

                    clearFields();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Failed!'),
                      ),
                    );
                  }
                },
              ),
              spaceHeight(24.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don’t have an account?   ",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 22 / 14.sp,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 22 / 14.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // switchScreenPush(context, const RegisterScreen());
                        },
                    ),
                  ],
                ),
              ),
              spaceHeight(),
            ],
          ),
        ),
      ),
    );
  }
}
