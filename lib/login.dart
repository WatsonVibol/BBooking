import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phnoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0), // Add some spacing
            ElevatedButton(
              onPressed: () async {
                // Implement login logic
                //Checking if user exists
                //UserCredential userCredential = await FirebaseAuth.instance
                //    .signInWithCredential(username, password);
                // If logged in navigate to HomePage
                if (true) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              phoneNumber: phnoneNumberController.text,
                            )),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0), // Add some spacing
            TextButton(
              onPressed: () {
                //Navigate to signup page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignupPage()), // Navigate to the SignupPage
                );
              },
              child: const Text('Not a member yet? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
