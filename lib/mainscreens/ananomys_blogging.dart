import 'package:flutter/material.dart';
import 'package:techslave/screen/home_screen2.dart';



class AnanomysBlogging extends StatefulWidget {
  const AnanomysBlogging({super.key});

  @override
  State<AnanomysBlogging> createState() => _AnanomysBloggingState();
}

class _AnanomysBloggingState extends State<AnanomysBlogging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen2(), 
              ),
            );
          },
          child: Text('Welocome to Anonymous Blogging'),
        ),
      ),
    );
  }
}
