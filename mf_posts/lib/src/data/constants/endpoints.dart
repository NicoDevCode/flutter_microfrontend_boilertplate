class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // endpoints
  static const String getPosts = baseUrl + "/posts";
  static const String getPostById = baseUrl + "/posts/"; // Agregar ID al final
  static const String createPost = baseUrl + "/posts";
  static const String updatePost = baseUrl + "/posts/"; // Agregar ID al final
  static const String deletePost = baseUrl + "/posts/"; // Agregar ID al final
} 