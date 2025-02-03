import 'package:flutter/material.dart';

class Gpt extends StatefulWidget {
  const Gpt({super.key});

  @override
  State<Gpt> createState() => _GptState();
}

class _GptState extends State<Gpt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hello")));
  }
}