import 'package:citizen_femme/view/profile/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_api/home_api.dart'; // Import CategoryProvider
import '../../view/travel.dart'; // Import TravelScreen
import '../../res/colors.dart'; // Import AppColors

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        return provider.loading
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.categories.length +
                    1, // +1 for the SupportScreen item
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  if (index < provider.categories.length) {
                    final category = provider.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TravelScreen(
                              categoryId: category.id,
                              categoryName: category.name,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 317,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              offset: const Offset(0, 2),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                          // borderRadius: BorderRadius.circular(8),
                          color: AppColors.whiteA700.withOpacity(0.75),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              Image.asset(
                                'assets/images/fluent_ios-arrow-24-regular.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Last item for SupportScreen
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 317,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              offset: const Offset(0, 2),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                          // borderRadius: BorderRadius.circular(8),
                          color: AppColors.whiteA700.withOpacity(0.75),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, 2),
                                blurRadius: 15,
                                spreadRadius: 0,
                              ),
                            ],
                            // borderRadius: BorderRadius.circular(8),
                            color: AppColors.whiteA700.withOpacity(0.75),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Support',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/fluent_ios-arrow-24-regular.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
      },
    );
  }
}
