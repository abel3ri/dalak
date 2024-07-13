import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleContainerMD extends StatelessWidget {
  ArticleContainerMD({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              contentProvider
                  .posts[index]['_embedded']['wp:featuredmedia'].first['link'],
              fit: BoxFit.fitHeight,
              width: 96,
              height: 96,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Html(
                  shrinkWrap: true,
                  data: contentProvider.posts[index]['title']['rendered'],
                  style: {
                    "*": Style(
                      textOverflow: TextOverflow.clip,
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.w500,
                      width: Width(
                        MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                  },
                ),
                Text(
                  contentProvider.selectedCategoryName.toUpperCase(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          timeago.format(
                            DateTime.parse(
                              contentProvider.posts[index]['modified'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
