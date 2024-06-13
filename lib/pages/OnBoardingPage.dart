import 'package:dalak/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () {},
              child: Text("Skip"),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/logo.jpg",
                  width: 120,
                  height: 120,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                "Welcome to Dalak",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Enjoy our apps!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Spacer(),
              FilledButton.icon(
                onPressed: () {
                  GoRouter.of(context).pushNamed("login");
                },
                iconAlignment: IconAlignment.end,
                label: Text("Login to continue"),
                icon: Icon(Icons.arrow_forward),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed("signup");
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
