import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techslave/loginScreen.dart';
import 'package:techslave/service/auth_service.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
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
              Icon(size: 70, Icons.lock),
              Text(
                "Password Reset",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: buildInputDecoration(
                    labelText: 'Plese Enter Your Email',
                    suffiIcon: Icons.email,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 330,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {
                      print("working");
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _authService.reset(_emailController.text);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("check your email"),
                          ));

                          Navigator.pushReplacementNamed(context, '/login');
                        } on FirebaseAuthException catch (e) {
                          String errormesasge =
                              'An error occured please try agin';
                          if (e.code == 'user-not-found') {
                            errormesasge = 'No account found for this user';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errormesasge)));
                        }
                      }
                    },
                    child: Text("Send Reset Link ")),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Loginscreen();
                      }));
                    },
                    child: Text("Back to Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildInputDecoration({required String labelText, required IconData suffiIcon}) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: Icon(suffiIcon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    ),
  );
}
