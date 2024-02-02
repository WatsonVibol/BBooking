import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final phnoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0), // Add some spacing between the fields
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 16.0), // Add some spacing
            ElevatedButton(
              onPressed: () async {
                // Implement login logic
                String username = usernameController.text;
                String password = passwordController.text;

                //Checking if user exists
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInWithCredential(username, password);
                // If logged in navigate to HomePage
                if (isLoggedIn) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              phoneNumber: phnoneNumberController.text,
                            )),
                  );
                } else {
                  // If not logged in show a toast
                  Fluttertoast.showToast(
                      msg: 'Username or password is incorrect',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
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
