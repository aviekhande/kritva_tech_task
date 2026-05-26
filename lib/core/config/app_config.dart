class AppConfig {
  AppConfig._();

  // JSONPlaceholder base URL (free public dummy API)
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Endpoints
  static const String postsEndpoint = '/posts';
  static const String usersEndpoint = '/users';
  static const String albumsEndpoint = '/albums';

  // Timeouts
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 15000;
}
