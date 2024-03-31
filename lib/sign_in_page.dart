import 'package:flutter/material.dart';
import 'home.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                        name: _nameController.text,
                        phoneNumber: _phoneNumberController.text),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
