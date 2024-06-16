import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/models/Success.dart';
import 'package:dalak_blog_app/pages/MainContentPage.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/MainShimmerLoading.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    return DefaultTabController(
      length: contentProvider.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dalak"),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none),
            ),
          ],
          bottom: TabBar(
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            tabs: contentProvider.categories.map((category) {
              return Tab(
                text: category['name'].toString().toUpperCase(),
              );
            }).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: List.generate(contentProvider.categories.length, (index) {
            return TabContent(
              categoryId: contentProvider.categories[index]['id'],
              categoryName: contentProvider.categories[index]['name'],
            );
          }),
        ),
      ),
    );
  }
}

class TabContent extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const TabContent({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  late final Future<Either<ErrorMessage, SuccessMessage>> fetchPosts;
  @override
  void initState() {
    fetchPosts = Provider.of<ContentProvider>(context, listen: false)
        .fetchPosts(endpoint: "posts?categories=${widget.categoryId}&_embed");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainShimmerLoading();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return MainContentPage(
            categoryName: widget.categoryName,
            categoryID: widget.categoryId,
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.paste,
                size: 60,
                color: Colors.grey,
              ),
              Text("No articles found"),
            ],
          ),
        );
      },
    );
  }
}
