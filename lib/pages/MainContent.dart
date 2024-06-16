import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/home/ArticleContainerXL.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainContent extends StatelessWidget {
  final String categoryName;
  final int categoryID;
  MainContent({
    required this.categoryName,
    required this.categoryID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final contentProvider = Provider.of<ContentProvider>(context);
    return Scaffold(
      backgroundColor: isDarkMode
          ? Theme.of(context).scaffoldBackgroundColor.lighten(5)
          : Theme.of(context).scaffoldBackgroundColor.darken(5),
      body: RefreshIndicator(
        onRefresh: () async {
          await contentProvider.fetchPosts(
            endpoint: "posts?categories=${categoryID}&_embed",
          );
        },
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemBuilder: (context, index) {
            return ArticleContainerXL(index: index, categoryName: categoryName);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
          itemCount: contentProvider.posts.length,
        ),
      ),
    );
  }
}
