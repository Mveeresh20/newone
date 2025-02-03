import 'package:flutter/material.dart';

class Welcomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return const Color.fromARGB(255, 172, 186, 173); // Color when the button is clicked
      }
      return Colors.blue; // Default color
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
                // style: 
                // ElevatedButton.styleFrom(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                //   backgroundColor: Colors.blue,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                
                
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return const Color.fromARGB(255, 131, 137, 131); // Color when the button is clicked
      }
      return Colors.purple; // Default color
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 41, vertical: 10),
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
                // style: ElevatedButton.styleFrom(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 41, vertical: 10),
                //   backgroundColor: Colors.purple,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
