import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mf_posts/src/domain/entity/post.dart';
import 'package:mf_posts/src/presentation/store/post_store.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  //stores:---------------------------------------------------------------------
  final PostStore _postStore = GetIt.instance<PostStore>();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  _fetchPosts() {
    _postStore.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPosts,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí iría la navegación a la pantalla de crear post
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _postStore.loading
            ? const Center(child: CircularProgressIndicator())
            : _buildListView();
      },
    );
  }

  Widget _buildListView() {
    return Observer(
      builder: (context) {
        final posts = _postStore.posts;
        
        if (posts.isEmpty) {
          return const Center(
            child: Text('No se encontraron posts'),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () => _postStore.getPosts(),
          child: ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (context, position) {
              return const Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(posts[position]);
            },
          ),
        );
      },
    );
  }

  Widget _buildListItem(Post post) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.article),
      title: Text(
        post.title ?? 'Sin título',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        post.body ?? 'Sin contenido',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        // Aquí iría la navegación al detalle del post
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.hasError) {
          return _showErrorMessage(_postStore.errorMessage!);
        }

        return const SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  Widget _showErrorMessage(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return const SizedBox.shrink();
  }
} 