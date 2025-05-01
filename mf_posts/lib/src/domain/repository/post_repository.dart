import 'dart:async';

import 'package:mf_posts/src/domain/entity/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  
  Future<Post?> findPostById(int id);
  
  Future<int> insert(Post post);
  
  Future<int> update(Post post);
  
  Future<int> delete(int id);
} 