import 'dart:async';

import 'package:mf_posts/src/data/api/dio_client.dart';
import 'package:mf_posts/src/data/constants/endpoints.dart';
import 'package:mf_posts/src/domain/entity/post.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PostApi(this._dioClient);

  /// Returns list of post in response
  Future<List<Post>> getPosts() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPosts);
      return (res.data as List).map((item) => Post.fromMap(item)).toList();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  
  /// Get post by id
  Future<Post> getPostById(int id) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPostById + id.toString());
      return Post.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  
  /// Create new post
  Future<Post> createPost(Post post) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.createPost,
        data: post.toMap(),
      );
      return Post.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  
  /// Update post
  Future<Post> updatePost(Post post) async {
    try {
      final res = await _dioClient.dio.put(
        Endpoints.updatePost + post.id.toString(),
        data: post.toMap(),
      );
      return Post.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  
  /// Delete post
  Future<bool> deletePost(int id) async {
    try {
      await _dioClient.dio.delete(Endpoints.deletePost + id.toString());
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
} 