import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Skip"),
          ),
        ],
      ),
    );
  }
}
