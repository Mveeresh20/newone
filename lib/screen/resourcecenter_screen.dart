import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techslave/screen/postcreation_screen.dart';
import 'package:techslave/screen/reviewsubmission_screen.dart';
import 'postdetail_screen.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedCategory;

  Stream<List<Map<String, dynamic>>> _fetchPosts() {
    var query = _firestore.collection('posts').orderBy('timestamp', descending: true);
    if (selectedCategory != null) {
      query = query.where('category', isEqualTo: selectedCategory);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anonymous Experience Sharing")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                hint: Text('Select Category'),
                value: selectedCategory,
                onChanged: (value) => setState(() => selectedCategory = value),
                items: ['Workplace', 'College', 'General']
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category)))
                    .toList(),
              ),
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts found.'));
                }

                final posts = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true, // Ensures ListView takes minimal space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListTile(
                      title: Text(post['title']),
                      subtitle: Text(post['content']),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetailScreen(postId: post['id'])),
                      ),
                    );
                  },
                );
              },
            ),
            // Button for navigating to Review Submission Screen
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewsubmissionScreen(),
                    ),
                  );
                },
                child: Text("Go to Review Submission"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column( // Stack buttons one above the other
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostCreationScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
              tooltip: 'Create Post',
            ),
          ),
        ],
      ),
    );
  }
}
