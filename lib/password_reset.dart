import 'package:flutter/material.dart';
import 'package:techslave/loginScreen.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Password Reset"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: buildInputDecoration(
                  labelText: 'password',
                  prefixIcon: Icons.lock_reset,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print("Reset Succefully");
                  },
                  child: Text("submit")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Loginscreen();
                    }));
                  },
                  child: Text("Back to Login")),
            ],
          ),
        ),
      ),
    );
  }
}

buildInputDecoration(
    {required String labelText, required IconData prefixIcon}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    ),
  );
}
