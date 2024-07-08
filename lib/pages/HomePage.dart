import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/models/Success.dart';
import 'package:dalak_blog_app/pages/MainContentPage.dart';
import 'package:dalak_blog_app/pages/SettingPage.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/MainShimmerLoading.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:provider/provider.dart';

class BasicTile {
  final String title;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    this.tiles = const [],
  });
}

final basicTiles = <BasicTile>[
  const BasicTile(title: "name", tiles: [
    BasicTile(title: 'kebee'),
    BasicTile(title: 'abebee'),
    BasicTile(title: 'rebee'),
  ]),
  const BasicTile(title: "kame", tiles: [
    BasicTile(title: 'kebee'),
    BasicTile(title: 'abebee'),
    BasicTile(title: 'rebee'),
  ]),
  const BasicTile(title: "Setting"),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;
  final List<Widget> _screens = [
    homeScreen(),
    ProfileScreen(),
    SettingsScreen(),
    SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    // int _currentIndex = 0;

    return DefaultTabController(
      length: contentProvider.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dalak"),
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
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
        ),
        body: _screens[myIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          selectedFontSize: 12,
          currentIndex: myIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white12,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Center(
                          child: Text(
                            "L O G O",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email_outlined),
                        title: Text("Contact US"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.link_rounded),
                        title: Text("Our Website"),
                        onTap: () {},
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.greenAccent[400],
                      //     radius: 20,
                      //   ),
                      //   title:
                      //       Text("Our Website", style: TextStyle(fontSize: 18)),
                      //   trailing: Icon(Icons.keyboard_arrow_down_outlined),
                      //   onTap: () {},
                      // ),
                      ...basicTiles.map((tile) => buildTile(context, tile)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildTile(BuildContext context, BasicTile tile,
    {double leftPadding = 16}) {
  if (tile.tiles.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: leftPadding),
      leading: CircleAvatar(
        backgroundColor: Colors.greenAccent[400],
        radius: 15,
      ),
      title: Text(tile.title, style: TextStyle(fontSize: 16)),
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailPage(tile: tile),
      //   ),
      // ),
    );
  } else {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: leftPadding),
        leading: CircleAvatar(
          backgroundColor: Colors.greenAccent[400],
          radius: 20,
        ),
        title: Text(tile.title, style: TextStyle(fontSize: 18)),
        children: tile.tiles
            .map((tile) =>
                buildTile(context, tile, leftPadding: 16 + leftPadding))
            .toList(),
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

class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    return DefaultTabController(
        length: contentProvider.categories.length,
        child: Scaffold(
          appBar: AppBar(
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
        ));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorite Page'),
    );
  }
}
