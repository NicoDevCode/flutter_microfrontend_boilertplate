// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PostStore.loading'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_PostStore.hasError'))
      .value;

  late final _$fetchPostsFutureAtom =
      Atom(name: '_PostStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<List<Post>> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<List<Post>> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$postsAtom = Atom(name: '_PostStore.posts', context: context);

  @override
  List<Post> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<Post> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$successAtom = Atom(name: '_PostStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PostStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getPostsAsyncAction =
      AsyncAction('_PostStore.getPosts', context: context);

  @override
  Future<void> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  late final _$getPostByIdAsyncAction =
      AsyncAction('_PostStore.getPostById', context: context);

  @override
  Future<Post?> getPostById(int id) {
    return _$getPostByIdAsyncAction.run(() => super.getPostById(id));
  }

  late final _$createPostAsyncAction =
      AsyncAction('_PostStore.createPost', context: context);

  @override
  Future<bool> createPost(Post post) {
    return _$createPostAsyncAction.run(() => super.createPost(post));
  }

  late final _$updatePostAsyncAction =
      AsyncAction('_PostStore.updatePost', context: context);

  @override
  Future<bool> updatePost(Post post) {
    return _$updatePostAsyncAction.run(() => super.updatePost(post));
  }

  late final _$deletePostAsyncAction =
      AsyncAction('_PostStore.deletePost', context: context);

  @override
  Future<bool> deletePost(int id) {
    return _$deletePostAsyncAction.run(() => super.deletePost(id));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
posts: ${posts},
success: ${success},
errorMessage: ${errorMessage},
loading: ${loading},
hasError: ${hasError}
    ''';
  }
}
