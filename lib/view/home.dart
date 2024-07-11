import 'package:citizen_femme/view/travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:citizen_femme/view_model/home_api/home_api.dart';
import 'package:citizen_femme/view_model/home_api/shimmer_effect.dart';
import 'package:citizen_femme/global/global.dart';
import 'package:citizen_femme/view/app_header/app_header.dart';
import 'package:citizen_femme/view/drawer/drawer.dart';
import 'package:citizen_femme/view_model/home_api/horizontail.dart';
import 'package:citizen_femme/res/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize fetchCategories on load
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: AppDrawerMenu()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<CategoryProvider>(
                builder: (context, provider, _) {
                  if (provider.loading) {
                    return ShimmerEffect(); // Show shimmer effect or loading indicator
                  } else if (provider.categories.isEmpty) {
                    return Center(child: Text('No categories found.'));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: provider.categories.length,
                      itemBuilder: (context, index) {
                        final imageData = provider.categories[index];
                        return GestureDetector(
                          onTap: () {
                            provider.selectCategory(
                                imageData.id, imageData.name);
                            provider.fetchPostsByCategory();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TravelScreen(
                                  categoryId: imageData.id,
                                  categoryName: imageData.name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    imageData.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  imageData.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Latest Podcast',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 150.h, // Set a fixed height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: horizontalDataList.length,
                itemBuilder: (context, index) {
                  final horizontalData = horizontalDataList[index];
                  return Container(
                    width: 150, // Set a fixed width for each item
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/images/latest_all.png'),
                          Expanded(
                            child: Text(
                              horizontalData.name,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height:
                                    1.57, // 22px line height / 14px font size
                                letterSpacing: -0.41,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            spaceHeight(20.h),
            Container(
              width: double.infinity,
              height: 117.h,
              child: Image.asset('assets/images/last.png'),
            ),
          ],
        ),
      ),
    );
  }
}
