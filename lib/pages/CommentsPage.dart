// import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:dalak_blog_app/widgets/CommentInputField.dart';
import 'package:dalak_blog_app/widgets/CommentShimmerLoading.dart';
import 'package:dalak_blog_app/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final post = Provider.of<ContentProvider>(context).post;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CommentInputField(),
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
      body: CommentShimmerLoading(),
    );
  }
}
