import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomTravelShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Adjust the number of shimmer items as needed
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 16.0,
                  width: 200.0, // Adjust width as needed
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
