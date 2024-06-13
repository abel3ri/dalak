import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 96),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "No Internet Connection",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "Check your Internet connection",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FilledButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacementNamed("splashPage");
                },
                child: const Text("Try again"))
          ],
        ),
      ),
    );
  }
}
