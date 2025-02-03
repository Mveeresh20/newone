import 'package:flutter/material.dart';

class Profilescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Back'),
            ),
            Text('User Profile', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
