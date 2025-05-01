import 'dart:async';

import 'package:mf_posts/src/data/api/post_api.dart';
import 'package:mf_posts/src/data/constants/db_constants.dart';
import 'package:mf_posts/src/data/datasource/post_datasource.dart';
import 'package:mf_posts/src/domain/entity/post.dart';
import 'package:mf_posts/src/domain/repository/post_repository.dart';
import 'package:sembast/sembast.dart';

class PostRepositoryImpl implements PostRepository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;

  // constructor
  PostRepositoryImpl(this._postApi, this._postDataSource);

  // Post: ---------------------------------------------------------------------
  @override
  Future<List<Post>> getPosts() async {
    try {
      // Intentar obtener datos desde la API
      final apiPosts = await _postApi.getPosts();
      
      // Guardar en la base de datos local
      for (var post in apiPosts) {
        await _postDataSource.insert(post);
      }
      
      return apiPosts;
    } catch (error) {
      print('Error al obtener posts desde API: $error');
      // Si falla la API, devolver datos de la BD local
      return _postDataSource.getPosts();
    }
  }

  @override
  Future<Post?> findPostById(int id) async {
    try {
      // Intentar obtener de la API primero
      final apiPost = await _postApi.getPostById(id);
      
      // Actualizar en la BD local
      await _postDataSource.update(apiPost);
      
      return apiPost;
    } catch (error) {
      print('Error al obtener post $id desde API: $error');
      // Si falla, obtener de la BD local
      return _postDataSource.getPostById(id);
    }
  }

  @override
  Future<int> insert(Post post) async {
    try {
      // Crear en la API
      final newPost = await _postApi.createPost(post);
      
      // Insertar en la BD local
      return _postDataSource.insert(newPost);
    } catch (error) {
      print('Error al insertar post en API: $error');
      // Intentar insertar solo en local
      return _postDataSource.insert(post);
    }
  }

  @override
  Future<int> update(Post post) async {
    try {
      // Actualizar en la API
      final updatedPost = await _postApi.updatePost(post);
      
      // Actualizar en la BD local
      return _postDataSource.update(updatedPost);
    } catch (error) {
      print('Error al actualizar post en API: $error');
      // Intentar actualizar solo en local
      return _postDataSource.update(post);
    }
  }

  @override
  Future<int> delete(int id) async {
    try {
      // Eliminar de la API
      await _postApi.deletePost(id);
      
      // Eliminar de la BD local
      return _postDataSource.delete(id);
    } catch (error) {
      print('Error al eliminar post de API: $error');
      // Intentar eliminar solo de local
      return _postDataSource.delete(id);
    }
  }
} 