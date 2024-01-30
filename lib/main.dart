import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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
      home: FutureBuilder<bool>(
        // Replace this with your method for checking if a user is logged in
        future: checkIfLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading while waiting for data
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return (snapshot.data ?? false)
                  ? const MainPage() // Replace with your HomePage widget
                  : const LoginPage(); // Replace with your LoginPage widget
            }
          }
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
