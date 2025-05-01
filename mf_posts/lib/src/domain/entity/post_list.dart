import 'package:json_annotation/json_annotation.dart';
import 'package:mf_posts/src/domain/entity/post.dart';

part 'post_list.g.dart';

@JsonSerializable()
class PostList {
  final List<Post>? posts;

  PostList({
    this.posts,
  });

  factory PostList.fromJson(Map<String, dynamic> json) => _$PostListFromJson(json);
  Map<String, dynamic> toJson() => _$PostListToJson(this);
  
  // Método adicional para compatibilidad con código existente
  factory PostList.fromJsonList(List<dynamic> json) {
    List<Post> posts = <Post>[];
    posts = json.map((post) => Post.fromMap(post)).toList();

    return PostList(
      posts: posts,
    );
  }
} 