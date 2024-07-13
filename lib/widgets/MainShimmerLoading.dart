import 'package:dalak_blog_app/widgets/MainShimmerContent.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainShimmerLoading extends StatelessWidget {
  const MainShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        physics: BouncingScrollPhysics(),
        child: Shimmer.fromColors(
          baseColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400,
          highlightColor:
              isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
          direction: ShimmerDirection.ltr,
          child: Column(
            children: [
              MainShimmerContent(),
              SizedBox(height: 12),
              MainShimmerContent(),
              SizedBox(height: 12),
              MainShimmerContent(),
              SizedBox(height: 12),
              MainShimmerContent(),
            ],
          ),
        ),
      ),
    );
  }
}
