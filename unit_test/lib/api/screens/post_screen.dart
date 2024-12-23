import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unit_test/api/models/models.dart';
import 'package:unit_test/api/services/services.dart';
import 'package:unit_test/api/widgets/post_widget.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<List<Post>> _posts;
  final ApiService _apiService = ApiService(
    http.Client(),
  );

  @override
  void initState() {
    super.initState();
    _posts = _apiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Posts Available'));
          } else {
            return PostList(posts: snapshot.data!);
          }
        },
      ),
    );
  }
}
