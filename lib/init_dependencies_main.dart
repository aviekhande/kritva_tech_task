part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // final sharedPreferences = await SharedPreferences.getInstance();

  // serviceLocator.registerLazySingleton<SharedPreferencesService>(
  //   () => SharedPreferencesService(sharedPreferences),
  // );
  // serviceLocator.registerLazySingleton(() => NetworkBloc());
  // serviceLocator.registerLazySingleton(() => Dio());

  serviceLocator.registerLazySingleton(() => AppRouter());

}
