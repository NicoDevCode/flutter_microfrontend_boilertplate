// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostList _$PostListFromJson(Map<String, dynamic> json) => PostList(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostListToJson(PostList instance) => <String, dynamic>{
      'posts': instance.posts,
    };
