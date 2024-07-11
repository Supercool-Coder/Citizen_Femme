import 'package:flutter/material.dart';
import 'package:citizen_femme/view/app_header/app_header.dart';
import 'package:citizen_femme/view/drawer/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:citizen_femme/res/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:citizen_femme/view_model/single_category_api/single_post_api.dart';
import 'package:shimmer/shimmer.dart';

class SingleShimmerCategoryScreen extends StatelessWidget {
  const SingleShimmerCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: AppDrawerMenu()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const CustomAppBar(),
              Consumer<SinglePostCategory>(
                builder: (context, provider, _) {
                  if (provider.loading || provider.singlePostDataList.isEmpty) {
                    return _buildShimmer(); // Show shimmer if loading or no data
                  } else {
                    final categoryData = provider.singlePostDataList.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          categoryData.imagePath,
                          fit: BoxFit.cover,
                          height: 150.0,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/Ellipse_1.png'), // Placeholder image
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'By: ${categoryData.authorName}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 22 / 14, // line-height / font-size
                                letterSpacing: -0.408,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              width: 33,
                              height: 1,
                              color: AppColors.black,
                              transform:
                                  Matrix4.rotationZ(-90 * 3.1415927 / 180),
                              transformAlignment: Alignment.center,
                            ),
                            Text(
                              '${categoryData.createDate}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 22 / 14, // line-height / font-size
                                letterSpacing: -0.408,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          child: Html(
                            data: categoryData.paragraph,
                            style: {
                              'html': Style(
                                fontFamily: 'Roboto',
                                fontSize: FontSize(14.sp),
                                fontWeight: FontWeight.w400,
                                lineHeight: LineHeight(22 / 14),
                              ),
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          Container(
            height: 10.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 10.0,
              ),
              SizedBox(width: 10.0),
              Container(
                height: 20.0,
                width: 120.0,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Container(
                height: 10.0,
                width: 50.0,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            height: 100.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
