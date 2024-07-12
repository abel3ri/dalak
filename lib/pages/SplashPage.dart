import 'package:dalak_blog_app/controllers/ContentController.dart';
import 'package:dalak_blog_app/providers/ContentProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    ContentController.fetchData(
      endpoint: "categories",
    ).then((res) {
      res.fold((l) {
        print(l.body);
        GoRouter.of(context).pushReplacementNamed("noConnection");
      }, (r) {
        final categories = r.map((category) {
          return {"id": category['id'], "name": category['name']};
        }).toList();
        Provider.of<ContentProvider>(context, listen: false)
            .populateCategories(categories);
        GoRouter.of(context).pushReplacementNamed("onBoarding");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/logo.jpg",
                  width: 96,
                  height: 96,
                ),
              ),
              const Spacer(),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
