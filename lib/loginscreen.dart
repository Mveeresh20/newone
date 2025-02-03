import 'package:flutter/material.dart';
import 'package:techslave/password_reset.dart';
import 'package:techslave/service/auth_service.dart';
import 'package:techslave/signupscreen.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0, //for the removing shadow
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.white.withOpacity(0.5),
              Colors.green.withOpacity(0.3)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration(
                  'Email',
                  Icons.email,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: _buildInputDecoration(
                  'Password',
                  Icons.lock,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await _authService.signIn(
                        _emailController.text, _passwordController.text);
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Failed')),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PasswordReset();
                  }));
                },
                child: Text('Forgot Password?'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Signupscreen();
                  }));
                },
                child: Text("Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      
      fillColor: Colors.blueGrey.withOpacity(0.4),
      // enabledBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Color(0x35949494))),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          color: Colors.white, // Border color when focused
          width: 2.5, // Increased border width when focused
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          color: Color(0x80FFFFFF) // 50% opacity (80 in hex)
          , // Border color when enabled
          width: 2.0, // Increased border width
        ),
      ),
    
          
      filled: true,
      
      labelStyle: const TextStyle(color: Colors.black),
      labelText: label,
      suffixIcon: Icon(suffixIcon, color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
