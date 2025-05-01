import 'package:mobx/mobx.dart';
import 'package:mf_posts/src/domain/entity/post.dart';
import 'package:mf_posts/src/domain/repository/post_repository.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // constructor:---------------------------------------------------------------
  _PostStore(this._postRepository);

  // repository:-----------------------------------------------------------------
  final PostRepository _postRepository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<Post>> emptyPostResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Post>> fetchPostsFuture =
      ObservableFuture<List<Post>>(emptyPostResponse);

  @observable
  List<Post> posts = [];

  @observable
  bool success = false;

  @observable
  String? errorMessage;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;
  
  @computed
  bool get hasError => errorMessage != null;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPosts() async {
    final future = _postRepository.getPosts();
    fetchPostsFuture = ObservableFuture(future);
    errorMessage = null;

    try {
      posts = await future;
      success = true;
    } catch (e) {
      errorMessage = e.toString();
      success = false;
    }
  }
  
  @action
  Future<Post?> getPostById(int id) async {
    try {
      return await _postRepository.findPostById(id);
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }
  
  @action
  Future<bool> createPost(Post post) async {
    try {
      await _postRepository.insert(post);
      await getPosts(); // Refrescar la lista
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
  
  @action
  Future<bool> updatePost(Post post) async {
    try {
      await _postRepository.update(post);
      await getPosts(); // Refrescar la lista
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
  
  @action
  Future<bool> deletePost(int id) async {
    try {
      await _postRepository.delete(id);
      await getPosts(); // Refrescar la lista
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
} 