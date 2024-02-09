import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'signup.dart';
import 'main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        // Initialize Firebase
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<bool>(
              // Replace this with your method for checking if a user is logged in
              future: checkIfLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading while waiting for data
                } else {
                  // Rest of your code
                  return const MainPage();
                }
              },
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
  // Rest of your code
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Something went wrong!',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      ),
    );
  }
}
