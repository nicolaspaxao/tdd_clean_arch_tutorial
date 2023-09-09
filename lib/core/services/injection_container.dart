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
  //* States
  sl.registerFactory(() => AuthBloc(createUser: sl(), getUser: sl()));

  //* Usecases
  sl.registerFactory(() => CreateUser(sl()));
  sl.registerFactory(() => GetUsers(sl()));

  //* Repositories
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));

  //* Datasources
  sl.registerFactory<AuthDatasource>(() => AuthDatasourceImpl(client: sl()));

  //* Http Client
  sl.registerFactory(() => http.Client);
}
