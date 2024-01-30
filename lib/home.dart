import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String phoneNumber;

  const HomePage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Your Home Page'),
            Text('Your number is: $phoneNumber'),
          ],
        ),
      ),
    );
  }
}
