import 'package:dalak_blog_app/controllers/UrlController.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/CircleIcon.dart';
import 'package:dalak_blog_app/widgets/CustomAppBar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesDetailPage extends StatelessWidget {
  const ArticlesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        leading: CircleIcon(
          icon: Icons.arrow_back_ios_new,
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        actions: [
          CircleIcon(
            icon: Icons.favorite_border,
            onPressed: () {},
          ),
          CircleIcon(
            icon: Icons.share,
            onPressed: () async {
              await Share.shareUri(Uri.parse(contentProvider.post['link']));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contentProvider.categoryName.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      timeago.format(
                        DateTime.parse(
                          contentProvider.posts.first['modified'],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Html(
              data: contentProvider.post['title']['rendered'],
              style: {
                "body": Style(
                  margin: Margins(left: Margin(0)),
                  fontSize: FontSize.larger,
                  fontWeight: FontWeight.bold,
                )
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: contentProvider.post['id'],
                child: Image.network(
                  contentProvider
                      .post['_embedded']['wp:featuredmedia'].first['link'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: isDarkMode
                          ? Theme.of(context)
                              .scaffoldBackgroundColor
                              .lighten(25)
                          : Theme.of(context)
                              .scaffoldBackgroundColor
                              .darken(25),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contentProvider
                              .post['_embedded']['author'].first['name'],
                        ),
                        Text("4 min read"),
                      ],
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () {
                    GoRouter.of(context).pushNamed("comments");
                  },
                  icon: Icon(Icons.chat_rounded),
                  label: Text("Comments"),
                )
              ],
            ),
            Html(
              data: contentProvider.post['content']['rendered'],
              style: {
                "a": Style(
                  textDecoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.primary,
                ),
              },
              onAnchorTap: (url, attributes, element) async {
                final res = await UrlController.launchUrls(url!);
                res.fold((l) {
                  l.showError(context);
                }, (r) {
                  print("Yeay!");
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
