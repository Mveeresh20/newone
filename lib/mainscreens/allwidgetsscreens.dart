import 'package:flutter/material.dart';
import 'package:techslave/homescreen.dart';
import 'package:techslave/mainscreens/ananomys_blogging.dart';
import 'package:techslave/mainscreens/explore_reaction.dart';
import 'package:techslave/mainscreens/gpt.dart';
import 'package:techslave/mainscreens/slavery.dart';
import 'package:techslave/service/auth_service.dart';

class Allwidgetsscreens extends StatefulWidget {
  final int initialIndex;

  const Allwidgetsscreens({super.key, this.initialIndex = 0});

  @override
  State<Allwidgetsscreens> createState() => _AllwidgetsscreensState();
}

class _AllwidgetsscreensState extends State<Allwidgetsscreens> {
  final AuthService authService = AuthService();
  int selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    Gpt(),
    Slavery(),
    ExploreReaction(),
    AnanomysBlogging()
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // Set initial index
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Homescreen();
                    }));
                  },
                  child: Text('Home',
                      style: TextStyle(
                          fontFamily: 'Roboto', fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
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
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.white
            ], // Light gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'GPT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Slavery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Explore Recreation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Anonymous Blogging',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black54,
        onTap: onItemTapped,
        backgroundColor: Colors.white, // Handle taps
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: showAddTransactionDialog,
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.purple.shade600, // Custom background color
      //   elevation: 5.0, // Slight shadow for elevation
      // ),
    );
  }
}
