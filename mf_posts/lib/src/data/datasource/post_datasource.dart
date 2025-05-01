import 'package:mf_posts/src/data/constants/db_constants.dart';
import 'package:mf_posts/src/data/datasource/sembast_client.dart';
import 'package:mf_posts/src/domain/entity/post.dart';
import 'package:sembast/sembast.dart';

class PostDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  final _postsStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // database instance
  final SembastClient _sembastClient;

  // Constructor
  PostDataSource(this._sembastClient);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Post post) async {
    return await _postsStore.add(_sembastClient.database, post.toMap());
  }

  Future<int> count() async {
    return await _postsStore.count(_sembastClient.database);
  }

  Future<List<Post>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _postsStore.find(
      _sembastClient.database,
      finder: finder,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final post = Post.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      post.id = snapshot.key;
      return post;
    }).toList();
  }

  Future<List<Post>> getPosts() async {
    print('Loading from database');

    // fetching data
    final recordSnapshots = await _postsStore.find(
      _sembastClient.database,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if(recordSnapshots.isNotEmpty) {
      return recordSnapshots.map((snapshot) {
        final post = Post.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        post.id = snapshot.key;
        return post;
      }).toList();
    }

    return [];
  }

  Future<Post?> getPostById(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final recordSnapshot = await _postsStore.findFirst(
      _sembastClient.database,
      finder: finder,
    );

    if (recordSnapshot != null) {
      final post = Post.fromMap(recordSnapshot.value);
      post.id = recordSnapshot.key;
      return post;
    }
    
    return null;
  }

  Future<int> update(Post post) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(post.id));
    return await _postsStore.update(
      _sembastClient.database,
      post.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    return await _postsStore.delete(
      _sembastClient.database,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _postsStore.drop(
      _sembastClient.database,
    );
  }
} 