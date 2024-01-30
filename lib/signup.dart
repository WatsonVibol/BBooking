import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'home.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  SignupPage({super.key});

  void _verifyPhoneNUmber() async {
    String phoneNumber = phoneNumberController.text;

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (auth.PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Fluttertoast.showToast(
            msg: 'Phone number verified',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      verificationFailed: (auth.FirebaseAuthException e) {
        Fluttertoast.showToast(
            msg: 'Phone number verification failed: ${e.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      codeSent: (String verificationId, int? resendToken) {
        Fluttertoast.showToast(
            msg: 'Code sent to $phoneNumber',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        String smsCode = '123456';

        auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Fluttertoast.showToast(
            msg: 'Code auto retrieval timeout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
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
            const SizedBox(height: 16.0), // Add some spacing between the fields
            TextField(
              controller: phoneNumberController,
              obscureText: false,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16.0), // Add some spacing
            ElevatedButton(
              onPressed: () async {
                //Implement signup logic
                String username = usernameController.text;
                String password = passwordController.text;
                if (await DatabaseHelper().userExists(username)) {
                  // User already exists
                  Fluttertoast.showToast(
                      msg:
                          'Username is already used. Please make a new username or login',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  // User doesn't exist
                  // Create a new user
                  User newUser = User(username, password);
                  await DatabaseHelper().saveUser(newUser);
                  //Toast 'User created'
                  Fluttertoast.showToast(
                      msg: 'A new user created',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  // Navigate to the home page
                  BuildContext ctx = context;
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                        builder: (ctx) => HomePage(
                              phoneNumber: phoneNumberController.text,
                            )),
                  );
                }
              },
              child: const Text('Create your account'),
            ),
            const SizedBox(height: 16.0), // Add some spacing
            TextButton(
              onPressed: () {
                //Navigate to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage()), // Navigate to the SignupPage
                );
              },
              child: const Text('Already a member? Login'),
            ),
            const SizedBox(height: 16.0), // Add some spacing
            TextButton(
              onPressed: _verifyPhoneNUmber,
              child: const Text('Reset Password with OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
