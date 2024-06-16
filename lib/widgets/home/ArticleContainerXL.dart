import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleContainerXL extends StatelessWidget {
  final int index;
  final String categoryName;
  const ArticleContainerXL(
      {super.key, required this.index, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    return GestureDetector(
      onTap: () {
        contentProvider.setPost(contentProvider.posts[index]);
        contentProvider.setCategoryName(categoryName);
        GoRouter.of(context).pushNamed("articleDetails");
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Hero(
                tag: contentProvider.posts[index]['id'],
                child: Image.network(
                  contentProvider.posts[index]['_embedded']['wp:featuredmedia']
                      .first['link'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('${categoryName}'.toUpperCase()),
            ),
            SizedBox(height: 8),
            Html(
              data: contentProvider.posts[index]['title']['rendered'],
              style: {
                "body": Style(
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.larger,
                  fontFamily: "Montserrat",
                ),
              },
            ),
            Html(
              data: (contentProvider.posts[index]['excerpt']['rendered']
                          as String)
                      .substring(0, 120) +
                  "...",
              style: {
                "a": Style(
                  textDecoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.primary,
                ),
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 4),
                      Text(timeago.format(DateTime.parse(
                          contentProvider.posts.first['modified']))),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
