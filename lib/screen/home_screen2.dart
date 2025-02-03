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
    var query =
        _firestore.collection('posts').orderBy('timestamp', descending: true);
    if (selectedCategory != null && selectedCategory != "all") {
      query = query.where('category', isEqualTo: selectedCategory);
    }
    return query.snapshots().map((snapshot) {
      print(snapshot.docs); // Debug output
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anonymous Experience Sharing")),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text('Select Category'),
            value: selectedCategory,
            onChanged: (value) => setState(() => selectedCategory = value),
            items: ['Workplace', 'College', 'General','all']
                .map((category) =>
                    DropdownMenuItem(value: category, child: Text(category)))
                .toList(),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
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
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsubmissionScreen(),
                      ),
                    );
                  },
                  child: Text("Reviewsubmission")))
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading widget typically used for a back button
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search and return an empty result
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Search logic to filter posts by title/content based on the query
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('posts')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final posts = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index].data()
                as Map<String, dynamic>; // Correctly accessing the post data
            return ListTile(
              title: Text(post['title'] ?? 'Untitled'),
              subtitle: Text(post['content'] ?? 'No content available'),
              onTap: () {
                // Navigate to the post detail screen when a result is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PostDetailScreen(postId: posts[index].id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display search suggestions as the user types
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('posts')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final posts = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index].data()
                as Map<String, dynamic>; // Correctly accessing the post data
            return ListTile(
              title: Text(post['title'] ?? 'Untitled'),
              subtitle: Text(post['content'] ?? 'No content available'),
              onTap: () {
                query = post[
                    'title']; // Update the query with the selected suggestion
                showResults(context); // Show the results view
              },
            );
          },
        );
      },
    );
  }
}
