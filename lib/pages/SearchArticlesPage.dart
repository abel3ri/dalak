import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/MainShimmerLoading.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchArticlesPage extends StatefulWidget {
  @override
  State<SearchArticlesPage> createState() => _SearchArticlesPageState();
}

class _SearchArticlesPageState extends State<SearchArticlesPage> {
  TextEditingController _searchController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (FocusScope.of(context).hasFocus)
              FocusScope.of(context).unfocus();
            GoRouter.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
        ),
        title: Form(
          key: _formKey,
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search news...",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.transparent,
            ),
            textInputAction: TextInputAction.search,
            validator: (value) {
              if (value!.isEmpty)
                ErrorMessage(body: "Please provide a search query")
                    .showError(context);

              return null;
            },
            onFieldSubmitted: (value) async {
              if (_formKey.currentState!.validate()) {
                contentProvider.toggleIsLoading();
                final res = await contentProvider.searchPosts(
                  value.trim().toLowerCase(),
                );
                contentProvider.toggleIsLoading();
                res.fold((l) {
                  l.showError(context);
                }, (r) {});
              }
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _searchController.text = "";
              });
            },
            icon: FaIcon(FontAwesomeIcons.xmark),
          )
        ],
      ),
      body: contentProvider.isLoading
          ? MainShimmerLoading()
          : contentProvider.searchResults.length == 0
              ? Center(
                  child: Text("No results found."),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  physics: BouncingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: contentProvider.searchResults.length,
                    itemBuilder: (context, index) {
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
                                    .searchResults[index]['_embedded']
                                        ['wp:featuredmedia']
                                    .first['link'],
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
                                    data: contentProvider.searchResults[index]
                                        ['title']['rendered'],
                                    style: {
                                      "*": Style(
                                        textOverflow: TextOverflow.clip,
                                        fontSize: FontSize(18),
                                        fontWeight: FontWeight.w500,
                                        width: Width(
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                        ),
                                      ),
                                    },
                                  ),
                                  Text(
                                    contentProvider
                                        .searchResults[index]['custom']
                                            ['categories']
                                        .first['name']
                                        .toString()
                                        .toUpperCase(),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                contentProvider
                                                        .searchResults[index]
                                                    ['modified'],
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
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      );
                    },
                  ),
                ),
    );
  }
}
