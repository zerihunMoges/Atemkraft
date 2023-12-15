import 'package:atemkraft/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:atemkraft/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc.dart';
import 'package:atemkraft/features/home/data/datasources/bolt_remote_datasource.dart';
import 'package:atemkraft/features/home/data/repositories/bolt_repository_impl.dart';
import 'package:atemkraft/features/home/domain/usecase/add_bolt_usecase.dart';
import 'package:atemkraft/features/home/domain/usecase/get_bolts_usecase.dart';
import 'package:atemkraft/features/home/domain/usecase/remove_bolt_usecase.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/admin/data/datasources/admin_remote_datasource.dart';
import '../../features/admin/data/repositories/admin_repository_impl.dart';
import '../../features/admin/domain/repositories/admin_repository.dart';
import '../../features/admin/domain/usecases/create_plan.dart';
import '../../features/admin/domain/usecases/fetch_clients.dart';
import '../../features/admin/domain/usecases/fetch_user_plans.dart';
import '../../features/admin/presentation/bloc/admin_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home/domain/repositories/bolt_repository.dart';
import '../network/network_info.dart';

var getIt = GetIt.instance;

Future<void> injectionInit() async {
  //! Bloc
  getIt.registerFactory(() => AuthBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => AdminBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => BoltBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ProfileBloc(getIt(), getIt()));

  //! Usecase
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));

  getIt.registerLazySingleton(() => FetchClientsUseCase(getIt()));
  getIt.registerLazySingleton(() => FetchUserPlansUseCase(getIt()));
  getIt.registerLazySingleton(() => CreatePlanUseCase(getIt()));

  //! Repository
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: getIt(), authRemoteDataSource: getIt()));
  getIt.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(
      networkInfo: getIt(), adminRemoteDataSource: getIt()));
  getIt.registerLazySingleton(() => AddBoltUsecase(getIt()));
  getIt.registerLazySingleton(() => GetBoltsUsecase(getIt()));
  getIt.registerLazySingleton(() => RemoveBoltUsecase(getIt()));
  getIt.registerLazySingleton(() => EditProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  //! Repository
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: getIt(), authRemoteDataSource: getIt()));
  getIt.registerLazySingleton<BoltRepository>(() => BoltRepositoryImpl(
        networkInfo: getIt(),
        boltRemoteDataSource: getIt(),
      ));

  //! Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<AdminRemoteDataSource>(
      () => AdminDataSourceImpl());

  getIt.registerLazySingleton<BoltRemoteDataSource>(
      () => BoltRemoteDataSourceImpl());
  //! Common

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
