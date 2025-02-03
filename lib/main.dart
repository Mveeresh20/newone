import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:techslave/firebase_options.dart';
import 'package:techslave/homescreen.dart';
import 'package:techslave/loginscreen.dart';
import 'package:techslave/models/post.dart';
import 'package:techslave/profilescreen.dart';

import 'package:techslave/signupscreen.dart';
import 'package:techslave/welcomescreen.dart';

Future<void> main() async {
  // Flutter engine initialize before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => Welcomescreen(),
        '/login': (context) => Loginscreen(),
        '/signup': (context) => Signupscreen(),
        '/home': (context) => Homescreen(),
        '/profile': (context) => Profilescreen(),
        // '/createPost': (context) => CreatepostScreen(),
        // '/home1': (context) => HomeScreen1(),
        // '/post': (context) {
        //   final post = ModalRoute.of(context)!.settings.arguments as Post;
        //   return PostScreen(post: post);
      },
    );
  }
}
