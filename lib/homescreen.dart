import 'package:flutter/material.dart';
import 'package:techslave/mainscreens/allwidgetsscreens.dart';
import 'package:techslave/profilescreen.dart';
import 'package:techslave/service/auth_service.dart';

class Homescreen extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Profile'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 400,
              height: 70,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), 
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, 
                mainAxisSpacing: 10, 
                crossAxisSpacing: 10, 
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Allwidgetsscreens(initialIndex: 0);
                      }));

                      
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), 
                      ),
                    ),
                    child: Center(child: const Text('GPT')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Allwidgetsscreens(initialIndex: 1);
                      }));

                     
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), 
                      ),
                    ),
                    child: const Text('Slavery'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Allwidgetsscreens(initialIndex: 2);
                      }));

                     
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), 
                      ),
                    ),
                    child: Center(child: const Text('Explore Recreation')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Allwidgetsscreens(initialIndex: 3);
                      }));

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), 
                      ),
                    ),
                    child: Center(child: const Text('Anonymous Blogging')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
