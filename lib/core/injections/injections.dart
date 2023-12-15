import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../network/network_info.dart';

var getIt = GetIt.instance;

Future<void> injectionInit() async {
  //! Bloc
  getIt.registerFactory(() => AuthBloc(getIt(), getIt(),getIt()));

  //! Usecase
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));

  //! Repository
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: getIt(), authRemoteDataSource: getIt()));

  //! Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  //! Common

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
