import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_router.dart';
import 'core/services/api_client/service/base_service.dart';
import 'core/services/shared_preferences/shared_preferences_service.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/home/data/datasources/home_remote_datasource.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // ── External ─────────────────────────────────────────────────────────────
  final sharedPrefs = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // ── Core Services ─────────────────────────────────────────────────────────
  serviceLocator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<BaseService>(() => BaseService());

  serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter());

  // ── Auth Feature ──────────────────────────────────────────────────────────
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(serviceLocator()),
  );

  // ── Home Feature ──────────────────────────────────────────────────────────
  serviceLocator.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<HomeBloc>(
    () => HomeBloc(serviceLocator()),
  );
}
