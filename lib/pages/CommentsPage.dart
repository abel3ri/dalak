import 'dart:async';

import 'package:dalak_blog_app/utils/constants.dart';
import 'package:dalak_blog_app/widgets/CommentInputField.dart';
import 'package:dalak_blog_app/widgets/CommentShimmerLoading.dart';
import 'package:dalak_blog_app/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: auth.currentUser == null
            ? Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Center(
                    child: Text(
                  "Login to make comments",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )),
              )
            : CommentInputField(),
      ),
      appBar: CustomAppBar(
        title: "Comments",
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CommentShimmerLoading();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No comments found!",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text("Be the first to comment"),
              ],
            ),
          );
        },
        future: Future.delayed(Duration(seconds: 3)),
      ),
    );
  }
}
