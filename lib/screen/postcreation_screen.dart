import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostCreationScreen extends StatefulWidget {
  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  String? selectedCategory;
  String? selectedSubcategory;
  bool enableComments = true;

  Future<void> _createPost() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final userId = _auth.currentUser!.uid;
    final postData = {
      'title': _titleController.text,
      'content': _contentController.text,
      'category': selectedCategory,
      'subcategory': selectedSubcategory,
      'tags': _tagsController.text.split(',').map((tag) => tag.trim()).toList(),
      'author_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'enable_comments': enableComments,
    };

    await _firestore.collection('posts').add(postData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Post created successfully')));
    Navigator.pop(context); // Navigate back after post creation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title')),
              SizedBox(height: 10),
              TextField(
                  controller: _contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                  maxLines: 5),
              SizedBox(height: 10),
              DropdownButton<String>(
                hint: Text('Select Category'),
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                items: ['Workplace', 'College', 'General']
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category)))
                    .toList(),
              ),
              if (selectedCategory != null)
                DropdownButton<String>(
                  hint: Text('Select Subcategory'),
                  value: selectedSubcategory,
                  onChanged: (value) {
                    setState(() {
                      selectedSubcategory = value;
                    });
                  },
                  items: ['Personal', 'Student', 'Professional']
                      .map((subcategory) => DropdownMenuItem(
                          value: subcategory, child: Text(subcategory)))
                      .toList(),
                ),
              SizedBox(height: 10),
              TextField(
                  controller: _tagsController,
                  decoration:
                      InputDecoration(labelText: 'Tags (comma-separated)')),
              SwitchListTile(
                title: Text('Enable Comments'),
                value: enableComments,
                onChanged: (value) => setState(() => enableComments = value),
              ),
              ElevatedButton(
                  onPressed: _createPost, child: Text('Create Post')),
            ],
          ),
        ),
      ),
    );
  }
}

