import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/models/Success.dart';
import 'package:dalak_blog_app/pages/FavoriteArticlesPage.dart';
import 'package:dalak_blog_app/pages/MainContentPage.dart';
import 'package:dalak_blog_app/pages/SearchArticlesPage.dart';
import 'package:dalak_blog_app/pages/SettingsPage.dart';
import 'package:dalak_blog_app/pages/VideoArticlesPage.dart';
import 'package:dalak_blog_app/providers/BottomNavBarProvider.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/MainShimmerLoading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("built");
    final bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
   
    return Scaffold(
      body: IndexedStack(
        index: bottomNavBarProvider.selectedIndex,
        children: [
          HomeScreen(),
          VideoArticlesPage(),
          SearchArticlesPage(),
          FavoriteArticlesPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedColor: Theme.of(context).colorScheme.primary,
        strokeColor: Theme.of(context).colorScheme.primary,
        currentIndex: bottomNavBarProvider.selectedIndex,
        onTap: (index) {
          bottomNavBarProvider.updateSelectedIndex(index);
        },
        items: [
          CustomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
          ),
          CustomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.youtube),
          ),
          CustomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          ),
          CustomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
          ),
          CustomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    return DefaultTabController(
      length: contentProvider.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed("search");
              },
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
