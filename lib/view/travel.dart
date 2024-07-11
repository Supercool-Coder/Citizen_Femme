import 'package:citizen_femme/view_model/travel_api.dart/travel_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:citizen_femme/view/app_header/category_header.dart';
import 'package:citizen_femme/view/single_category.dart';
import 'package:citizen_femme/res/colors.dart';
import 'package:citizen_femme/view_model/home_api/home_api.dart';
import 'package:citizen_femme/view_model/travel_api.dart/travel_api.dart';

class TravelScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const TravelScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false)
          .selectCategory(widget.categoryId, widget.categoryName);
      Provider.of<PostCategory>(context, listen: false)
          .fetchPostsByCategory(context, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(title: widget.categoryName),
      body: Consumer<PostCategory>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return CustomTravelShimmer(); // Show shimmer loading placeholders
          } else if (provider.categoryDataList.isEmpty) {
            return Center(child: Text('No posts found.'));
          } else {
            return ListView.builder(
              itemCount: provider.categoryDataList.length,
              itemBuilder: (context, index) {
                final categoryData = provider.categoryDataList[index];
                return _buildListItem(categoryData);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildListItem(CategoryData categoryData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            categoryData.imagePath,
            fit: BoxFit.fill,
            height: 150.0,
            width: double.infinity,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              categoryData.paragraph,
              style: TextStyle(),
            ),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleCategoryScreen(
                    categoryId:
                        categoryData.id, // Pass the id to SingleCategoryScreen
                  ),
                ),
              );
            },
            child: Text(
              "Read More",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
