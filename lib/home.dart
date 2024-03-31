import 'package:bbooking/my_profile.dart';
import 'package:bbooking/sign_in_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  String phoneNumber;
  String name;

  HomePage({Key? key, required this.name, this.phoneNumber = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.person), text: 'Account'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
              Tab(icon: Icon(Icons.logout), text: 'Logout'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Phone Number'),
                      content: Text('Your phone number is $phoneNumber'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Home Page')),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.name, // Replace this with the actual account name
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfile(),
                        ),
                      );
                    },
                    child: const Text('Load Profile'),
                  ),
                ],
              ),
            ),
            Center(child: Text('Settings Page')),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                },
                child: const Text('logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
