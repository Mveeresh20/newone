import 'package:flutter/material.dart';
import 'package:techslave/homescreen.dart';
import 'package:techslave/service/auth_service.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // bool _obscureText = true;
  bool _passwordInVisible = true;

  final AuthService _authService = AuthService();


  Color buttonColor = Colors.green;
  //  void _toggle(){
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validation function
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Enter a Password';
    } else if (password.length < 6 ||
        !RegExp(r'[A-Za-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must be at least 6 characters ';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.6),
                Colors.purple.withOpacity(0.6),
                Colors.black.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: _buildInputDecoration('Email', Icons.email),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: _passwordInVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.4),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14,color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2.5
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
            width:2.5 ,
          )
        ),
         suffixIcon: IconButton(
      icon: Icon(
        _passwordInVisible ? Icons.visibility_off : Icons.visibility, 
        color:Colors.black, 
      ),
      onPressed: () {
        setState(() {
          _passwordInVisible = !_passwordInVisible; 
        });
      },
    )
      ),
                   
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: _buildInputDecoration(
                        'Confirm Password', Icons.lock_outline),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return Homescreen();
                  //     }));
                  //   },
                  ElevatedButton(
                    onPressed: () async {
        
                      
                      if (_formKey.currentState!.validate()) {
                        final user = await _authService.signUp(
                            _emailController.text, _passwordController.text);
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('The Account is alreaady rergisterd')),
                          );
                        }
                      }
                     
                    },
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Colors.white.withOpacity(0.0),
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
          color: Colors.white // 50% opacity (80 in hex)
          , // Border color when enabled
          width: 2.0, // Increased border width
        ),
      ),
      // focusedBorder:
      //     const OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),
      //     ),
      filled: true,
      labelStyle: const TextStyle(color: Colors.black),
      labelText: label,
      suffixIcon: Icon(suffixIcon, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
