import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Three Tabs Page'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.one_k)),
              Tab(icon: Icon(Icons.two_k)),
              Tab(icon: Icon(Icons.three_k)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Tab 1')),
            Center(child: Text('Tab 2')),
            Center(child: Text('Tab 3')),
          ],
        ),
      ),
    );
  }
}
