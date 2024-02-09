import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup.dart';
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
        // Initilization of Firebase
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: checkIfLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    return const MainPage();
                  } else {
                    return const SignupPage();
                  }
                }
                return const CircularProgressIndicator();
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences
        .getInstance(); // Import the SharedPreferences package

    final token = prefs.getString('user_token');
    if (token == null || token.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
