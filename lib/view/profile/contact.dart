import 'package:citizen_femme/view/common_text/common_text_field.dart';
import 'package:citizen_femme/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:citizen_femme/global/global.dart';
import 'package:citizen_femme/res/components/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  ValueNotifier obscurePassword = ValueNotifier<bool>(true);

  void clearFields() {
    username.clear();
    email.clear();
    subject.clear();
    message.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                spaceHeight(40.h),
                Container(
                  width: double.infinity,
                  height: 24.h,
                  alignment: Alignment.center,
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                      fontFamily: 'Domine',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      height: 22 / 24, // Line height / Font size
                      letterSpacing: -0.40799999237060547,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                spaceHeight(24.h),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Username',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CommonTextField(
                        controller: username,
                        keyboardType: TextInputType.text,
                        hasError: false,
                      ),
                    ],
                  ),
                ),
                spaceHeight(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Email id',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CommonTextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        hasError: false,
                      ),
                    ],
                  ),
                ),
                spaceHeight(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Subject',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CommonTextField(
                        controller: subject,
                        keyboardType: TextInputType.text,
                        hasError: false,
                      ),
                    ],
                  ),
                ),
                spaceHeight(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Message',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          // children: const [
                          //   TextSpan(
                          //     text: ' *',
                          //     style: TextStyle(
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CommonTextField(
                        controller: message,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        hasError: false,
                      ),
                    ],
                  ),
                ),
                spaceHeight(),
                AppButton(
                  btnText: "Submit",
                  onPress: () async {
                    // Call login method asynchronously
                    await authProvider.ConstactUs(
                      username.text.toString(),
                      email.text.toString(),
                      subject.text.toString(),
                      message.text.toString(),
                      context,
                    );

                    if (authProvider.Submitted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Successfully Submitted!'),
                        ),
                      );
                      clearFields();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Submittion Failed!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
