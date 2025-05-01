import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mf_posts/src/data/api/dio_client.dart';
import 'package:mf_posts/src/data/api/post_api.dart';
import 'package:mf_posts/src/data/constants/db_constants.dart';
import 'package:mf_posts/src/data/datasource/post_datasource.dart';
import 'package:mf_posts/src/data/datasource/sembast_client.dart';
import 'package:mf_posts/src/data/repository/post_repository_impl.dart';
import 'package:mf_posts/src/domain/repository/post_repository.dart';
import 'package:mf_posts/src/presentation/store/post_store.dart';
import 'package:path_provider/path_provider.dart';

class PostsModule {
  static final GetIt _getIt = GetIt.instance;
  
  static Future<void> init() async {
    // Registrar dependencias de API
    _getIt.registerLazySingleton<Dio>(() => Dio());
    _getIt.registerLazySingleton<DioClient>(() => DioClient(_getIt<Dio>()));
    _getIt.registerLazySingleton<PostApi>(() => PostApi(_getIt<DioClient>()));
    
    // Registrar dependencias de base de datos
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = appDocDir.path;
    
    final sembastClient = await SembastClient.provideDatabase(
      databaseName: DBConstants.DB_NAME,
      databasePath: dbPath,
    );
    
    _getIt.registerSingleton<SembastClient>(sembastClient);
    _getIt.registerLazySingleton<PostDataSource>(
      () => PostDataSource(_getIt<SembastClient>()),
    );
    
    // Registrar repositorio
    _getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(
        _getIt<PostApi>(),
        _getIt<PostDataSource>(),
      ),
    );
    
    // Registrar store
    _getIt.registerLazySingleton<PostStore>(
      () => PostStore(_getIt<PostRepository>()),
    );
  }
  
  static void dispose() {
    if (_getIt.isRegistered<SembastClient>()) {
      _getIt.unregister<SembastClient>();
    }
  }
} 