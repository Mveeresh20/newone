import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewsubmissionScreen extends StatefulWidget {
  const ReviewsubmissionScreen({super.key});

  @override
  State<ReviewsubmissionScreen> createState() => _ReviewsubmissionScreenState();
}

class _ReviewsubmissionScreenState extends State<ReviewsubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Reviewsubmission"),
          leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); 
    },
  ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Select category Type:"),

            ],
          ),
          
        ),
      ),
    );
  }
}
