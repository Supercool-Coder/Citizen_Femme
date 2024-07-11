import 'package:flutter/material.dart';
import 'package:citizen_femme/view/app_header/app_header.dart';
import 'package:citizen_femme/view/drawer/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:citizen_femme/res/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:citizen_femme/view_model/single_category_api/single_post_api.dart';
import 'package:citizen_femme/view_model/single_category_api/single_category_shimmer.dart';

class SingleCategoryScreen extends StatefulWidget {
  final int categoryId;

  const SingleCategoryScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  _SingleCategoryScreenState createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  late Future<void> _fetchPostFuture;

  @override
  void initState() {
    super.initState();
    _fetchPostFuture = _fetchSinglePost();
  }

  Future<void> _fetchSinglePost() async {
    try {
      await Provider.of<SinglePostCategory>(context, listen: false)
          .fetchSinghPost(context, widget.categoryId);
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed
    }
  }

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
              FutureBuilder<void>(
                future: _fetchPostFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SingleShimmerCategoryScreen();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading data.'));
                  } else {
                    return Consumer<SinglePostCategory>(
                      builder: (context, provider, _) {
                        if (provider.singlePostDataList.isEmpty) {
                          return Center(child: Text('No data found.'));
                        } else {
                          final categoryData =
                              provider.singlePostDataList.first;
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
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/Ellipse_1.png'),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        'By: ${categoryData.authorName}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 22 / 14,
                                          letterSpacing: -0.408,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 1,
                                      color: AppColors.black,
                                      transform: Matrix4.rotationZ(
                                          -90 * 3.1415927 / 180),
                                      transformAlignment: Alignment.center,
                                    ),
                                    SizedBox(
                                        width: 10
                                            .w), // Adding spacing between line and date
                                    Expanded(
                                      child: Text(
                                        '${categoryData.createDate}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 22 / 14,
                                          letterSpacing: -0.408,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
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
}
