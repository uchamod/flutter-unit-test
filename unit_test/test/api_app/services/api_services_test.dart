import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_test/api/models/models.dart';
import 'package:unit_test/api/services/services.dart';

import 'api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  //test group for fetch posts
  group("API testing using mock client to fetch posts", () {
    test("test api fetch succsussful senario with status code 200", () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response(
              '[{"id":1,"title":"bio","body":"test-body"}]', 200));
      expect(await ApiService(client).fetchPosts(), isA<List<Post>>());
    });
    
    test("test api fetch with error", () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response('Failed to load posts', 404));
      expect(ApiService(client).fetchPosts(), throwsException);
    });
  });

//test group for fetch post by id
  group("API testing using mock client to fetch posts by id", () {
    test("test api fetch succsussful senario with status code 200", () async {
      final client = MockClient();
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')))
          .thenAnswer((_) async =>
              http.Response('{"id":1,"title":"bio","body":"test-body"}', 200));
      expect(await ApiService(client).fetchPostById(1), isA<Post>());
    });

    test("fetch posts by id  with error", () async {
      final client = MockClient();
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')))
          .thenAnswer((_) async => http.Response('Failed to load posts', 404));
      expect(ApiService(client).fetchPostById(1), throwsException);
    });
  });
}
