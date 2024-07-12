import 'package:dalak_blog_app/pages/HomePage.dart';
import 'package:dalak_blog_app/pages/OnBoardingPage.dart';
import 'package:dalak_blog_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CheckAuthCangePage extends StatelessWidget {
  const CheckAuthCangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
        if (snapshot.hasError || snapshot.data == null) {
          return OnBoardingPage();
        }
        return HomePage();
      },
    );
  }
}
