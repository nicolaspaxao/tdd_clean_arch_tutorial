import 'package:dummy_project/src/auth/data/datasource/auth_datasource.dart';
import 'package:dummy_project/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:dummy_project/src/auth/domain/repositories/auth_repository.dart';
import 'package:dummy_project/src/auth/domain/usecases/create_user.dart';
import 'package:dummy_project/src/auth/domain/usecases/get_user.dart';
import 'package:dummy_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => AuthBloc(
          createUser: sl(),
          getUser: sl(),
        ))

    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))

    // Data Sources
    ..registerLazySingleton<AuthDatasource>(
        () => AuthDatasourceImpl(client: sl()))

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
